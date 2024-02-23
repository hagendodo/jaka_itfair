import { Router } from "express";
import multer from "multer";
import penjamuController from "../controllers/penjamuController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";

const penjamuRouter = Router();

const commonMiddleware = [
  basicMiddleware.verifyAccount,
  basicMiddleware.isAccountActivated,
];

const upload = multer({ storage: multer.memoryStorage() });

penjamuRouter.get(
  "/",
  basicMiddleware.verifyAccount,
  penjamuController.getAllPenjamu
);
penjamuRouter.get("/:id", commonMiddleware, penjamuController.getPenjamuById);
penjamuRouter.post(
  "/",
  [commonMiddleware, upload.single("filename")],
  penjamuController.createPenjamu
);
penjamuRouter.post(
  "/ktm",
  [commonMiddleware, upload.single("filename")],
  penjamuController.uploadKtmPenjamu
);
penjamuRouter.put(
  "/:id",
  [commonMiddleware, upload.single("filename")],
  penjamuController.updatePenjamu
);
penjamuRouter.delete("/:id", commonMiddleware, penjamuController.deletePenjamu);

export { penjamuRouter };
