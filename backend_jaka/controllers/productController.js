import productService from "../services/productService.js";
import { responseType } from "../types/responseType.js";

const getAllProduct = async (req, res) => {
  try {
    const { data, error } = await productService.getAllproduct(req.query);

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(
        responseType(
          `Retrieve all product for merchant ${req.query.merchant_id}`,
          data,
          false
        )
      );
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const getProductById = async (req, res) => {
  try {
    const { data, error } = await productService.getProductById(req.params.id);

    if (error) {
      throw new Error(error);
    }
    return res.status(200).send(responseType("Product Found", data[0], false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const createProduct = async (req, res) => {
  try {
    await productService.createProduct(req.file, req.body);
    return res
      .status(200)
      .send(responseType("Successfully create product", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const updateProduct = async (req, res) => {
  try {
    await productService.updateProduct(req.file, req.body, req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully update product", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const deleteProduct = async (req, res) => {
  try {
    await productService.deleteProduct(req.params.id);
    return res
      .status(200)
      .send(responseType("Successfully delete product", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

export default {
  getAllProduct,
  getProductById,
  createProduct,
  updateProduct,
  deleteProduct,
};
