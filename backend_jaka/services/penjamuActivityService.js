import { initializeApp } from "firebase/app";
import { deleteDoc, doc, getFirestore, setDoc } from "firebase/firestore";
import firebaseConfig from "../config/firebaseConfig.js";
import { supabaseClient } from "../models/supabaseClient.js";

const app = initializeApp(firebaseConfig.firebaseConfig);

const db = getFirestore(app);

const activatePenjamu = async (data) => {
  const updatedAt = new Date().toLocaleString("en-US", {
    timeZone: "Asia/Jakarta",
  });
  return supabaseClient
    .from("penjamu_activities")
    .upsert({ id: data.id, status: "active", updated_at: updatedAt });
};

const deactivatePenjamu = async (data) => {
  const updatedAt = new Date().toLocaleString("en-US", {
    timeZone: "Asia/Jakarta",
  });

  try {
    await deleteDoc(doc(db, "current_maps", data.id));

    return supabaseClient
      .from("penjamu_activities")
      .upsert({ id: data.id, status: null, updated_at: updatedAt });
  } catch (err) {
    throw new Error(err);
  }
};

const checkOrderPenjamu = async (data) => {
  return supabaseClient
    .from("penjamu_activities")
    .select("status")
    .eq("id", data.id)
    .single();
};

const updatePositionPenjamu = async (data) => {
  return await setDoc(doc(db, "current_maps", data.penjamu_id), {
    lat: data.lat,
    lng: data.lng,
  });
};

const arrivedOrder = async (data) => {
  return supabaseClient
    .from("penjamu_activities")
    .update({ status: "arrived" })
    .eq("id", data.id);
};

export default {
  activatePenjamu,
  deactivatePenjamu,
  checkOrderPenjamu,
  updatePositionPenjamu,
  arrivedOrder,
};
