import { Router } from "express";
import orderController from "../controllers/orderController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";

const orderRouter = Router();

const commonMiddleware = [
  basicMiddleware.verifyAccount,
  basicMiddleware.isAccountActivated,
];

orderRouter.get("/", orderController.getAllHistoryOrder);
orderRouter.get("/:id", orderController.getAllHistoryOrder);
orderRouter.post("/", orderController.createOrder);
orderRouter.post("/accept", orderController.matchingOrderToPenjamu);
orderRouter.get("/check/:id", orderController.checkOrderStatus);

export { orderRouter };
