import { Router } from "express";
import userController from "../controllers/userController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";

const userRouter = Router();

const commonMiddleware = [basicMiddleware.verifyAccount];

userRouter.get("/", commonMiddleware, userController.getAllUser);
userRouter.get("/:id", commonMiddleware, userController.getUserById);
userRouter.post(
  "/:id",
  [...commonMiddleware, basicMiddleware.isAccountActivated],
  userController.updateUser
);

export { userRouter };
