import randomInteger from "random-int";
import { supabaseClient } from "../models/supabaseClient.js";

const getAllPenjamu = async () => {
  try {
    return await supabaseClient.from("penjamus").select();
  } catch (err) {
    return err;
  }
};

const getPenjamuById = async (id) => {
  try {
    return await supabaseClient.from("penjamus").select().eq("id", id);
  } catch (err) {
    return err;
  }
};

const uploadKtmPenjamu = async (file) => {
  try {
    const image = await uploadHelper.uploadImage(file);
    return image.url;
  } catch (err) {
    return err;
  }
};

const createPenjamu = async (file, data) => {
  try {
    const image = await uploadHelper.uploadImage(file);

    const { error } = await supabaseClient.from("penjamus").insert({
      nim: data.nim,
      name: data.name,
      email: data.email,
      phone: data.phone,
      password: data.password,
      ktm: image.url,
      otp: randomInteger(100000, 999999),
      is_actived: false,
      is_problem: false,
    });

    return error;
  } catch (err) {
    return err;
  }
};

const updatePenjamu = async (file, data, id) => {
  try {
    if (file) {
      const image = await uploadHelper.uploadImage(file);

      data.image = image.url;

      const { error } = await supabaseClient
        .from("penjamus")
        .update(data)
        .eq("id", id);

      return error;
    }

    const { error } = await supabaseClient
      .from("penjamus")
      .update(data)
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

const deletePenjamu = async (id) => {
  try {
    return await supabaseClient.from("penjamus").delete().eq("id", id);
  } catch (err) {
    return err;
  }
};

export default {
  getAllPenjamu,
  getPenjamuById,
  uploadKtmPenjamu,
  createPenjamu,
  updatePenjamu,
  deletePenjamu,
};
