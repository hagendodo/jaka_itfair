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
  commonMiddleware,
  penjamuActivityController.activatePenjamu
);

penjamuActivityRouter.post(
  "/deactivate/:id",
  commonMiddleware,
  penjamuActivityController.deactivatePenjamu
);

export { penjamuActivityRouter };
