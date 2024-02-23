import cartService from "../services/cartService.js";
import { responseType } from "../types/responseType.js";

const getAllCart = async (req, res) => {
  try {
    const { data, error } = await cartService.getAllCart(req.query);

    if (error) {
      throw new Error(error.message);
    }

    return res.status(200).send(responseType("Retrieve all cart", data, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const getCartById = async (req, res) => {
  try {
    const { data, error } = await cartService.getCartById(req.params.id);

    if (error) {
      throw error;
    }
    return res.status(200).send(responseType("Cart Found", data[0], false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const createCart = async (req, res) => {
  try {
    const error = await cartService.createCart(req.body);

    if (error) {
      throw new Error(error);
    }

    return res
      .status(201)
      .send(responseType("Successfully create cart", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const updateCart = async (req, res) => {
  try {
    await cartService.updateCart(req.body, req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully update cart", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const deleteCart = async (req, res) => {
  try {
    await cartService.deleteCart(req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully delete cart", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

export default {
  getAllCart,
  getCartById,
  createCart,
  updateCart,
  deleteCart,
};
