import { supabaseClient } from "../models/supabaseClient.js";

const getAllUser = async () => {
  try {
    return await supabaseClient.from("users").select();
  } catch (err) {
    return err;
  }
};

const getUserById = async (id) => {
  try {
    return await supabaseClient.from("users").select().eq("id", id);
  } catch (err) {
    return err;
  }
};

const updateUser = async (data, id) => {
  try {
    const { error } = await supabaseClient
      .from("users")
      .update(data)
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

export default {
  getAllUser,
  getUserById,
  updateUser,
};
