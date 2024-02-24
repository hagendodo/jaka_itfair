import userService from "../services/userService.js";
import { responseType } from "../types/responseType.js";

const getAllUser = async (req, res) => {
  try {
    const { data, error } = await userService.getAllUser();

    if (error) {
      throw new Error(error);
    }

    return res.status(200).send(responseType("Retrieve all user", data, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const getUserById = async (req, res) => {
  try {
    const { data, error } = await userService.getUserById(req.params.id);

    if (error) {
      throw error;
    }
    return res.status(200).send(responseType("User Found", data[0], false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const updateUser = async (req, res) => {
  try {
    await userService.updateUser(req.body, req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully update user", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

export default {
  getAllUser,
  getUserById,
  updateUser,
};
