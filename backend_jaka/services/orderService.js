import { firebaseClient } from "../models/firebaseClient.js";
import { getFirestore, collection, getDocs } from "firebase/firestore/lite";

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

const chooseAllActivePenjamu = async (myLocation) => {
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

  // Get the nearest location
  const nearestLocation = mapListWithDistances[0];

  // Use transaction to delete the nearest location and insert it into a new collection
  const nearestLocationRef = doc(db, "current_maps", nearestLocation.id);
  const newCollectionRef = collection(db, "temporary_orders");

  await runTransaction(db, async (transaction) => {
    // Delete the nearest location
    transaction.delete(nearestLocationRef);

    // Insert the nearest location into a new collection
    transaction.set(newCollectionRef.doc(nearestLocation.id), nearestLocation);
  });

  // Remove the nearest location from the list
  mapListWithDistances.shift();

  return mapListWithDistances;
};

const getAllHistoryOrder = async (queryString) => {
  try {
    if (!queryString.type) {
      throw new Error("Please add type (penjamu, merchant, user)");
    }

    let queryBuilder = supabaseClient
      .from("history_orders_view")
      .select()
      .eq(`${queryString.type}_id`, queryString.id);

    return await queryBuilder;
  } catch (err) {
    return err;
  }
};

const getHistoryOrderById = async (id) => {
  try {
    let queryBuilder = supabaseClient
      .from("history_orders_view")
      .select()
      .eq("id", id);

    return await queryBuilder;
  } catch (err) {
    return err;
  }
};

const createOrder = async (x) => {
  const penjamus = chooseAllActivePenjamu();

  const { data, error } = supabaseClient
    .from("penjamu_activites")
    .select("status")
    .eq("id", penjamus[0].id);
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
