import { supabaseClient } from "../models/supabaseClient.js";
import {
  doc,
  getFirestore,
  runTransaction,
  collection,
  getDocs,
} from "firebase/firestore";
import firebaseConfig from "../config/firebaseConfig.js";
import { initializeApp } from "firebase/app";
import messageHelper from "../helper/messageHelper.js";
import { error } from "firebase-functions/logger";

const app = initializeApp(firebaseConfig.firebaseConfig);

const db = getFirestore(app);

const calculateDistance = (point1, point2) => {
  const lat1 = point1.lat;
  const lon1 = point1.lng;
  const lat2 = point2.lat;
  const lon2 = point2.lng;

  const R = 6371; // Radius of the earth in km
  const dLat = ((lat2 - lat1) * Math.PI) / 180; // deg2rad below
  const dLon = ((lon2 - lon1) * Math.PI) / 180;
  const a =
    0.5 -
    Math.cos(dLat) / 2 +
    (Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      (1 - Math.cos(dLon))) /
      2;

  return R * 2 * Math.asin(Math.sqrt(a)); // Distance in km
};

const pairingPenjamuWithOrder = async (myLocation, orderId) => {
  const currentMapsCollection = collection(db, "current_maps");
  const currentMapSnapshot = await getDocs(currentMapsCollection);
  const currentMapList = currentMapSnapshot.docs.map((doc) => ({
    id: doc.id,
    ...doc.data(),
  }));

  // Calculate distances and add them to the objects
  const mapListWithDistances = currentMapList.map((map) => {
    const distance = calculateDistance(myLocation, {
      lat: map.lat,
      lng: map.lng,
    });
    return { ...map, distance };
  });

  // Sort the list based on distance
  mapListWithDistances.sort((a, b) => a.distance - b.distance);

  let nearestLocation;
  let nearestLocationIndex = 0;

  while (
    !nearestLocation &&
    nearestLocationIndex < mapListWithDistances.length
  ) {
    // Get the nearest location
    nearestLocation = mapListWithDistances[nearestLocationIndex];

    // Use transaction to delete the nearest location and insert it into a new collection
    const nearestLocationRef = doc(db, "current_maps", nearestLocation.id);
    const setTemporaryOrderRef = doc(
      db,
      "temporary_orders",
      nearestLocation.id
    );
    try {
      await runTransaction(db, async (transaction) => {
        // Delete the nearest location
        transaction.delete(nearestLocationRef);

        // Insert the nearest location into a new collection
        transaction.set(setTemporaryOrderRef, {
          orderId: orderId,
          penjamuId: nearestLocation.id,
        });
      });
    } catch (error) {
      console.error("Transaction failed:", error);
      // If transaction fails, rollback and move to the next nearest location
      nearestLocation = null;
      nearestLocationIndex++;
    }
  }

  if (nearestLocation) {
    // Return the id of the nearest location
    return nearestLocation.id;
  } else {
    // If no location is found, return null or throw an error
    return null;
  }
};

const getAllHistoryOrder = async (queryString) => {
  try {
    if (queryString.type == "merchant") {
      return await supabaseClient
        .from("orders")
        .select(
          "id, address, total, status, notes, created_at, penjamus (id, name), users (id, name), detail_orders(products(id, name, image, merchant_id), price, quantity)"
        )
        .eq(`detail_orders.products.merchant_id`, queryString.id);
    } else {
      return await supabaseClient
        .from("orders")
        .select(
          "id, address, total, status, notes, created_at, penjamus (id, name), users (id, name), detail_orders(products(id, name, image, merchants(id, name)), price, quantity)"
        )
        .eq(`${queryString.type}_id`, queryString.id);
    }
  } catch (err) {
    return err;
  }
};

const getHistoryOrderById = async (id, queryString) => {
  try {
    return await supabaseClient
      .from("orders")
      .select(
        "id, address, total, notes, created_at, penjamus (id, name), users (id, name), detail_orders(products(id, name, image), price)"
      )
      .eq(`${queryString.type}_id`, queryString.id)
      .eq("id", id);
  } catch (err) {
    return err;
  }
};

const getAllActiveOrder = async (queryString) => {
  try {
    return await supabaseClient
      .from("orders")
      .select(
        "id, address, total, notes, created_at, penjamus (id, name), users (id, name), detail_orders(products(id, name, image), price)"
      )
      .eq(`${queryString.type}_id`, queryString.id);
  } catch (err) {
    return err;
  }
};

const getCountActivePenjamu = async () => {
  const currentMapsCollection = collection(db, "current_maps");
  try {
    const snapshot = await getDocs(currentMapsCollection);
    return snapshot.size;
  } catch (error) {
    console.error("Error getting documents:", error);
    return 0;
  }
};

const orderCanceledByNotExistPenjamu = async (id) => {
  await supabaseClient
    .from("orders")
    .update({
      status: "canceled",
    })
    .eq("id", id);

  return {
    data: null,
    error: "Tidak ada penjamu aktif saat ini",
  };
};

const createOrder = async (x) => {
  try {
    const order = await supabaseClient
      .from("orders")
      .insert({
        user_id: x.user_id,
        user_lat: parseFloat(x.lat),
        user_lng: parseFloat(x.lng),
        address: x.address,
      })
      .select();

    if (order.error) {
      throw new Error(order.error);
    }

    const orderData = order.data[0];

    const totalPrice = 0;

    x.products.forEach(async (element) => {
      const { error } = await supabaseClient.from("detail_orders").insert({
        order_id: orderData.id,
        product_id: element.id,
        price: element.price,
        quantity: element.quantity,
      });

      totalPrice += element.price * element.quantity;

      if (error) {
        console.log(error);
        throw new Error("Insert ke detail_orders nya gagal");
      }
    });

    await supabaseClient
      .from("orders")
      .update({
        total: totalPrice,
      })
      .eq("id", orderData.id);

    await supabaseClient
      .from("carts")
      .delete()
      .eq("merchant_id", x.merchant_id)
      .eq("user_id", x.user_id);

    const getTotalActivePenjamu = await getCountActivePenjamu();

    if (getTotalActivePenjamu <= 0) {
      return await orderCanceledByNotExistPenjamu(orderData.id);
    }

    const merch = await supabaseClient
      .from("merchants")
      .select()
      .eq("id", x.merchant_id)
      .single();

    const templateMessageNotifToMerchant = `📦 Pesanan Masuk

    Halo,
    
    Kamu menerima pesanan baru untuk diproses. Silahkan cek aplikasi merchant.
    
    Nomor Pesanan: #${orderData.id}
    Total Penjamu: ${getTotalActivePenjamu}
    
    Silakan segera proses pesanan ini agar dapat memenuhi kebutuhan pelanggan kita dengan baik.
    
    Terima kasih atas kerja keras Anda dalam memberikan layanan terbaik kepada pelanggan kita.
    
    Salam,
    Jaka
    Jaka Corp.    
    `;

    await messageHelper.sendMessageToWhatsapp(
      merch.data.phone,
      templateMessageNotifToMerchant
    );

    return {
      data: null,
      error: null,
    };
  } catch (err) {
    console.log(err);
    throw new Error(err);
  }
};

const matchingOrderToPenjamu = async (x) => {
  try {
    if (x.status == "canceled") {
      await supabaseClient
        .from("orders")
        .update({
          status: "canceled",
        })
        .eq("id", x.order_id);

      return {
        data: null,
        error: "Merchant menolak pesanan",
      };
    }

    const merch = await supabaseClient
      .from("merchants")
      .select()
      .eq("id", x.merchant_id)
      .single();

    const penjamuId = await pairingPenjamuWithOrder(
      {
        lat: parseFloat(merch.data.lat),
        lng: parseFloat(merch.data.lng),
      },
      x.order_id
    );

    if (penjamuId === null) {
      return await orderCanceledByNotExistPenjamu(x.order_id);
    }

    await supabaseClient
      .from("penjamu_activities")
      .update({
        status: "order",
        order_id: x.order_id,
      })
      .eq("id", penjamuId);

    const orderData = await supabaseClient
      .from("orders")
      .update({
        penjamu_id: penjamuId,
        status: "active",
      })
      .eq("id", x.order_id)
      .select(
        "id, address, total, notes, created_at, penjamus (id, name), users (id, name), detail_orders(products(id, name, image), price)"
      )
      .single();

    const penjamu = await supabaseClient
      .from("penjamus")
      .select()
      .eq("id", penjamuId)
      .single();

    const templateMessageNotifToPenjamu = `📦 Pesanan Masuk, Siap untuk di antar

    Halo,
    
    Kamu menerima pesanan baru untuk diantar. Silahkan cek aplikasi Jaka.
    
    Nomor Pesanan: #${x.order_id}
    Nama Penerima: **${orderData.data.users.name}**
    Alamat Pengantaran: **${orderData.data.address}**
    
    Silakan segera proses pesanan ini agar dapat memenuhi kebutuhan pelanggan kita dengan baik.
    
    Terima kasih atas kerja keras Anda dalam memberikan layanan terbaik kepada pelanggan kita.
    
    Salam,
    Jaka
    Jaka Corp. `;

    await messageHelper.sendMessageToWhatsapp(
      penjamu.data.phone,
      templateMessageNotifToPenjamu
    );

    return {
      data: {
        order: orderData,
        penjamu: penjamuId,
      },
      error: null,
    };
  } catch (err) {
    console.log(err);
    throw new Error(err);
  }
};

const checkOrderStatus = async (id) => {
  return await supabaseClient
    .from("orders")
    .select("status")
    .eq("id", id)
    .single();
};

export default {
  getAllHistoryOrder,
  getAllActiveOrder,
  getHistoryOrderById,
  createOrder,
  matchingOrderToPenjamu,
  checkOrderStatus,
};
