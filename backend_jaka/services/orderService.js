import { firebaseClient } from "../models/firebaseClient.js";
import { getFirestore, collection, getDocs } from "firebase/firestore/lite";
import { supabaseClient } from "../models/supabaseClient.js";

const client = firebaseClient();
const db = getFirestore(client);

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
    const newCollectionRef = collection(db, "temporary_orders");

    try {
      await runTransaction(db, async (transaction) => {
        // Delete the nearest location
        transaction.delete(nearestLocationRef);

        // Insert the nearest location into a new collection
        transaction.set(newCollectionRef.doc(nearestLocation.id), {
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

const createOrder = async (x) => {
  const order = await supabaseClient
    .from("orders")
    .insert({
      user_id: x.user_id,
    })
    .select();

  const orderData = order[0];

  x.products.forEach(async (element) => {
    const { error } = await supabaseClient.from("detail_orders").insert({
      order_id: orderData.id,
      product_id: element.product_id,
      price: element.price,
      quantity: element.quantity,
    });

    if (error) {
      console.log(error);
      throw new Error("Insert ke detail_orders nya gagal");
    }
  });

  const penjamuId = pairingPenjamuWithOrder(
    {
      lat: x.lat,
      lng: x.lng,
    },
    orderData.id
  );

  if (penjamuId === null) {
    return {
      data: null,
      error: "Tidak ada penjamu aktif saat ini",
    };
  }

  await supabaseClient
    .from("penjamu_activities")
    .update({
      status: "order",
    })
    .eq("id", penjamuId);

  return {
    data: {
      order_id: orderData.id,
      penjamu: penjamuId,
      products: x.products,
    },
    error: null,
  };
};

/*

 1. select active penjamu
 2. choose penjamu
 2. send confirmation take order and (detail order, destination coordinate) to penjamu
 3. if decline, to step 2
 4. change status penjamu to onDelivery
 5. send notification to user and detail penjamu
 6. 

*/

export default {
  getAllHistoryOrder,
  getHistoryOrderById,
  createOrder,
};
