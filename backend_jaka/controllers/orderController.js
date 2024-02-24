import orderService from "../services/orderService.js";
import { responseType } from "../types/responseType.js";

const getAllHistoryOrder = async (req, res) => {
  try {
    if (!req.query || !req.query.type || !req.query.id) {
      throw new Error("Pelase add query string type and id");
    }

    const { data, error } = await orderService.getAllHistoryOrder(req.query);

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(responseType("Retrieve all history order", data, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const getHistoryOrderById = async (req, res) => {
  try {
    const { data, error } = await orderService.getHistoryOrderById(
      req.params.id
    );

    if (error) {
      throw error;
    }
    return res
      .status(200)
      .send(responseType("History order found", data[0], false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

export default {
  getAllHistoryOrder,
  getHistoryOrderById,
};
