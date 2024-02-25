import uploadHelper from "../helper/uploadHelper.js";
import { supabaseClient } from "../models/supabaseClient.js";

const getAllproduct = async (queryString = null) => {
  try {
    let queryBuilder = supabaseClient.from("products").select();

    if (queryString.merchant_id) {
      queryBuilder.eq("merchant_id", queryString.merchant_id);
    }

    return await queryBuilder;
  } catch (err) {
    return err;
  }
};

const getProductById = async (id) => {
  try {
    return await supabaseClient.from("products").select().eq("id", id);
  } catch (err) {
    return err;
  }
};

const createProduct = async (file, data) => {
  try {
    try {
      const image = await uploadHelper.uploadImage(file);

      const { error } = await supabaseClient.from("products").insert({
        merchant_id: data.merchant_id,
        name: data.name,
        price: data.price,
        description: data.description,
        image: image.url,
      });

      return error;
    } catch (err) {
      return err;
    }
  } catch (err) {}
};

const updateProduct = async (file, data, id) => {
  try {
    if (file) {
      const image = await uploadHelper.uploadImage(file);

      const { error } = await supabaseClient
        .from("products")
        .update({
          name: data.name,
          price: data.price,
          description: data.description,
          image: image.url,
        })
        .eq("id", id);

      return error;
    }

    const { error } = await supabaseClient
      .from("products")
      .update({
        name: data.name,
        price: data.price,
        description: data.description,
      })
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

const deleteProduct = async (id) => {
  try {
    return await supabaseClient.from("products").delete().eq("id", id);
  } catch (err) {
    return err;
  }
};

export default {
  getAllproduct,
  getProductById,
  createProduct,
  updateProduct,
  deleteProduct,
};
