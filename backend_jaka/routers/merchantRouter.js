import { Router } from "express";
import merchantController from "../controllers/merchantController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";

const merchantRouter = Router();

const commonMiddleware = [
  basicMiddleware.verifyAccount,
  basicMiddleware.isAccountActivated,
];

merchantRouter.get(
  "/",
  basicMiddleware.verifyAccount,
  merchantController.getAllMerchant
);
merchantRouter.get(
  "/ratings",
  commonMiddleware,
  merchantController.getAllMerchantWithRating
);
merchantRouter.get(
  "/:id",
  commonMiddleware,
  merchantController.getMerchantById
);
merchantRouter.post("/", commonMiddleware, merchantController.createMerchant);
merchantRouter.put("/:id", commonMiddleware, merchantController.updateMerchant);
merchantRouter.delete(
  "/:id",
  commonMiddleware,
  merchantController.deleteMerchant
);

export { merchantRouter };
