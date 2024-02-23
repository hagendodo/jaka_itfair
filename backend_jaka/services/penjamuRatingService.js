import { supabaseClient } from "../models/supabaseClient.js";

const getPenjamuRatingById = async (id) => {
  try {
    return await supabaseClient.from("penjamu_ratings").select().eq("id", id);
  } catch (err) {
    return err;
  }
};

const createPenjamuRating = async (data) => {
  try {
    const { error } = await supabaseClient.from("penjamu_ratings").insert({
      penjamu_id: data.penjamu_id,
      order_id: data.order_id,
      rating: data.rating,
    });

    return error;
  } catch (err) {
    return err;
  }
};

const deletePenjamuRating = async (id) => {
  try {
    return await supabaseClient.from("penjamu_ratings").delete().eq("id", id);
  } catch (err) {
    return err;
  }
};

export default {
  getPenjamuRatingById,
  createPenjamuRating,
  deletePenjamuRating,
};
