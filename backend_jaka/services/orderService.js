import { firebaseClient } from "../models/firebaseClient.js";
import { getFirestore, collection, getDocs } from "firebase/firestore/lite";

const client = firebaseClient();
const db = getFirestore(client);

const chooseAllActivePenjamu = async () => {
  const currentMapsCollection = collection(db, "current_maps");
  const currentMapSnapshot = await getDocs(currentMapsCollection);
  const currentMapList = currentMapSnapshot.docs.map((doc) => doc.data());
  return currentMapList;
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
};
