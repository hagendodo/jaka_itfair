import penjamuActivityService from "../services/penjamuActivityService.js";
import { responseType } from "../types/responseType.js";

const activatePenjamu = async (req, res) => {
  try {
    if (!req.params) {
      throw new Error("Please add params");
    }

    const { error } = await penjamuActivityService.activatePenjamu(req.params);

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(
        responseType(
          "Successfully change status penjamu become active to take an order",
          null,
          false
        )
      );
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const deactivatePenjamu = async (req, res) => {
  try {
    if (!req.params) {
      throw new Error("Please add params");
    }

    const { error } = await penjamuActivityService.deactivatePenjamu(
      req.params
    );

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(
        responseType(
          "Successfully change status penjamu become deactive from take an order",
          null,
          false
        )
      );
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const checkOrderPenjamu = async (req, res) => {
  try {
    if (!req.params) {
      throw new Error("Please add id penjamu");
    }

    const { data, error } = await penjamuActivityService.checkOrderPenjamu(
      req.params
    );

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(responseType("Data penjamu found", data, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const updatePositionPenjamu = async (req, res) => {
  try {
    await penjamuActivityService.updatePositionPenjamu(req.body);

    return res
      .status(200)
      .send(responseType("Success update position penjamu", null, false));
  } catch (err) {
    console.log(err);
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const arrivedOrder = async (req, res) => {
  try {
    await penjamuActivityService.arrivedOrder(req.params);

    return res
      .status(200)
      .send(responseType("Success arrived penjamu", null, false));
  } catch (err) {
    console.log(err);
    return res.status(400).send(responseType(err.message, null, true));
  }
};

export default {
  activatePenjamu,
  deactivatePenjamu,
  checkOrderPenjamu,
  updatePositionPenjamu,
  arrivedOrder,
};
