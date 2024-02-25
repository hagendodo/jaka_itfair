import { Router } from "express";
import penjamuActivityController from "../controllers/penjamuActivityController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";

const penjamuActivityRouter = Router();

const commonMiddleware = [
  basicMiddleware.verifyAccount,
  basicMiddleware.isAccountActivated,
];

penjamuActivityRouter.post(
  "/activate/:id",
  penjamuActivityController.activatePenjamu
);

penjamuActivityRouter.get(
  "/check-order/:id",
  penjamuActivityController.checkOrderPenjamu
);

penjamuActivityRouter.post(
  "/deactivate/:id",
  penjamuActivityController.deactivatePenjamu
);

penjamuActivityRouter.post(
  "/update-position",
  penjamuActivityController.updatePositionPenjamu
);

export { penjamuActivityRouter };
