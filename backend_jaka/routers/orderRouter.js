import { Router } from "express";
import orderController from "../controllers/orderController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";

const orderRouter = Router();

const commonMiddleware = [
  basicMiddleware.verifyAccount,
  basicMiddleware.isAccountActivated,
];

orderRouter.get("/", commonMiddleware, orderController.getAllHistoryOrder);
orderRouter.get("/:id", commonMiddleware, orderController.getAllHistoryOrder);
orderRouter.post("/", commonMiddleware, orderController.createOrder);

export { orderRouter };
