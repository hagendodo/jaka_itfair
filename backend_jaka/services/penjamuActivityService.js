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

export default {
  activatePenjamu,
  deactivatePenjamu,
  checkOrderPenjamu,
};
