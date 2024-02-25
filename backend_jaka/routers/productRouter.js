import { Router } from "express";
import multer from "multer";
import productController from "../controllers/productController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";

const productRouter = Router();

const commonMiddleware = [basicMiddleware.verifyAccount];

const upload = multer({ storage: multer.memoryStorage() });

productRouter.get("/", commonMiddleware, productController.getAllProduct);
productRouter.get("/:id", commonMiddleware, productController.getProductById);
productRouter.post(
  "/",
  basicMiddleware.verifyAccount,
  upload.single("filename"),
  productController.createProduct
);
productRouter.put("/:id", commonMiddleware, productController.updateProduct);
productRouter.delete("/:id", commonMiddleware, productController.deleteProduct);

export { productRouter };
