import merchantService from "../services/merchantService.js";
import { responseType } from "../types/responseType.js";

const getAllMerchant = async (req, res) => {
  try {
    const { data, error } = await merchantService.getAllMerchant();

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(responseType("Retrieve all merhcant", data, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const getAllMerchantWithRating = async (req, res) => {
  try {
    const { data, error } = await merchantService.getAllMerchantWithRating(
      req.query
    );

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(responseType("Retrieve all merhcant", data, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const getMerchantById = async (req, res) => {
  try {
    const { data, error } = await merchantService.getMerchantById(
      req.params.id
    );

    if (error) {
      throw error;
    }
    return res.status(200).send(responseType("Merchant Found", data[0], false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const createMerchant = async (req, res) => {
  try {
    await merchantService.createMerchant(req.body);
    return res
      .status(200)
      .send(responseType("Successfully create merchant", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const updateMerchant = async (req, res) => {
  try {
    await merchantService.updateMerchant(req.body, req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully update merchant", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const deleteMerchant = async (req, res) => {
  try {
    await merchantService.deleteMerchant(req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully delete merchant", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

export default {
  getAllMerchant,
  getAllMerchantWithRating,
  getMerchantById,
  createMerchant,
  updateMerchant,
  deleteMerchant,
};
