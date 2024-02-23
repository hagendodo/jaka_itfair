import { supabaseClient } from "../models/supabaseClient.js";

const getAllMerchant = async (queryString) => {
  try {
    const limit = queryString.limit ?? 5;
    return await supabaseClient
      .from("merchant_ratings_view")
      .select()
      .order("ratings", { ascending: false })
      .limit(limit);
  } catch (err) {
    return err;
  }
};

const getMerchantById = async (id) => {
  try {
    return await supabaseClient
      .from("merchant_ratings_view")
      .select()
      .eq("id", id);
  } catch (err) {
    return err;
  }
};

const createMerchant = async (data) => {
  try {
    const { error } = await supabaseClient.from("merchants").insert({
      name: data.name,
      address: data.address,
      description: data.description,
      lat: data.lat,
      lng: data.lng,
    });

    return error;
  } catch (err) {
    return err;
  }
};

const updateMerchant = async (data, id) => {
  try {
    const { error } = await supabaseClient
      .from("merchants")
      .update({
        name: data.name,
        address: data.address,
        description: data.description,
        lat: data.lat,
        lng: data.lng,
      })
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

const deleteMerchant = async (id) => {
  try {
    return await supabaseClient.from("merchants").delete().eq("id", id);
  } catch (err) {
    return err;
  }
};

export default {
  getAllMerchant,
  getMerchantById,
  createMerchant,
  updateMerchant,
  deleteMerchant,
};
