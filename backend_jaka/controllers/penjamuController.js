import penjamuService from "../services/penjamuService.js";
import { responseType } from "../types/responseType.js";

const getAllPenjamu = async (req, res) => {
  try {
    const { data, error } = await penjamuService.getAllPenjamu();

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(responseType("Retrieve all penjamu", data, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const getPenjamuById = async (req, res) => {
  try {
    const { data, error } = await penjamuService.getPenjamuById(req.params.id);

    if (error) {
      throw error;
    }
    return res.status(200).send(responseType("Penjamu Found", data[0], false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const createPenjamu = async (req, res) => {
  try {
    await penjamuService.createPenjamu(req.body);
    return res
      .status(200)
      .send(responseType("Successfully create penjamu", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const uploadKtmPenjamu = async (req, res) => {
  try {
    await penjamuService.uploadKtmPenjamu(req.body);
    return res
      .status(200)
      .send(responseType("Successfully upload KTM penjamu", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const updatePenjamu = async (req, res) => {
  try {
    await penjamuService.updatePenjamu(req.body, req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully update penjamu", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const deletePenjamu = async (req, res) => {
  try {
    await penjamuService.deletePenjamu(req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully delete penjamu", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

export default {
  getAllPenjamu,
  getPenjamuById,
  createPenjamu,
  uploadKtmPenjamu,
  updatePenjamu,
  deletePenjamu,
};
