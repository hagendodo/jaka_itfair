import { Router } from "express";
import multer from "multer";
import cartController from "../controllers/cartController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";

const cartRouter = Router();

const commonMiddleware = [
  basicMiddleware.verifyAccount,
  basicMiddleware.isAccountActivated,
];

cartRouter.get("/", commonMiddleware, cartController.getAllCart);
cartRouter.get("/:id", commonMiddleware, cartController.getCartById);
cartRouter.post("/", commonMiddleware, cartController.createCart);
cartRouter.put("/:id", commonMiddleware, cartController.updateCart);
cartRouter.delete("/:id", commonMiddleware, cartController.deleteCart);

export { cartRouter };
