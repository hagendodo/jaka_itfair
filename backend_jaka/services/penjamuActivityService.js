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

export default {
  activatePenjamu,
  deactivatePenjamu,
};
