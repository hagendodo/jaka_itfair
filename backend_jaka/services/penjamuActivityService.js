import { initializeApp } from "firebase/app";
import { doc, getFirestore, setDoc } from "firebase/firestore";
import firebaseConfig from "../config/firebaseConfig.js";
import { supabaseClient } from "../models/supabaseClient.js";

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
  return supabaseClient
    .from("penjamu_activities")
    .upsert({ id: data.id, status: null, updated_at: updatedAt });
};

const checkOrderPenjamu = async (data) => {
  return supabaseClient
    .from("penjamu_activities")
    .select("status")
    .eq("id", data.id)
    .single();
};

const updatePositionPenjamu = async (data) => {
  const app = initializeApp(firebaseConfig.firebaseConfig);

  const db = getFirestore(app);

  return await setDoc(doc(db, "current_maps", data.penjamu_id), {
    lat: data.lat,
    lng: data.lng,
  });
};

export default {
  activatePenjamu,
  deactivatePenjamu,
  checkOrderPenjamu,
  updatePositionPenjamu,
};
