import { supabaseClient } from "../models/supabaseClient.js";

const getAllCart = async (queryString = null) => {
  try {
    if (!queryString || !queryString.user_id || !queryString.merchant_id) {
      return {
        data: null,
        error: {
          message: "Please add query string user id and merchant id!",
        },
      };
    }

    const userId = queryString.user_id;
    const merchantId = queryString.merchant_id;

    return await supabaseClient
      .from("carts")
      .select()
      .eq("user_id", userId)
      .eq("merchant_id", merchantId);
  } catch (err) {
    return err;
  }
};

const getCartById = async (id) => {
  try {
    return await supabaseClient.from("carts").select().eq("id", id);
  } catch (err) {
    return err;
  }
};

const createCart = async (data) => {
  try {
    const cartExist = await supabaseClient
      .from("carts")
      .select("id, quantity")
      .eq("user_id", data.user_id)
      .eq("merchant_id", data.merchant_id)
      .eq("product_id", data.product_id);

    if (cartExist.error) {
      return cartExist.error;
    }

    let queryBuilder = supabaseClient.from("carts");

    if (cartExist.data.length === 0) {
      await queryBuilder.insert({
        user_id: data.user_id,
        merchant_id: data.merchant_id,
        product_id: data.product_id,
        quantity: 1,
      });
    } else {
      await queryBuilder
        .update({
          quantity: cartExist.data[0].quantity + 1,
        })
        .eq("id", cartExist.data[0].id);
    }

    return queryBuilder.error;
  } catch (err) {
    return err;
  }
};

const updateCart = async (data, id) => {
  try {
    const { error } = await supabaseClient
      .from("carts")
      .insert(data)
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

const deleteCart = async (id) => {
  try {
    return await supabaseClient.from("carts").delete().eq("id", id);
  } catch (err) {
    return err;
  }
};

export default {
  getAllCart,
  getCartById,
  createCart,
  updateCart,
  deleteCart,
};
