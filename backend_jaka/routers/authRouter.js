import { Router } from "express";
import authController from "../controllers/authController.js";
import basicMiddleware from "../middlewares/verifyAccountMiddleware.js";
import multer from "multer";

const authRouter = Router();

const commonMiddleware = [basicMiddleware.verifyAccount];
const upload = multer({ storage: multer.memoryStorage() });

authRouter.post("/login", authController.login);
authRouter.post("/register", authController.register);
authRouter.post(
  "/logout",
  basicMiddleware.verifyAccount,
  authController.logout
);
authRouter.post("/verify-otp", authController.verifyOtp);
authRouter.post("/upload-ktm", upload.single("ktm"), authController.uploadKtm);

// Token Login Needed
authRouter.post("/accept/:id", commonMiddleware, authController.accept);
authRouter.post("/decline/:id", commonMiddleware, authController.decline);
authRouter.post("/deactivate/:id", commonMiddleware, authController.deactivate);
authRouter.post("/activate/:id", commonMiddleware, authController.activate);

//authRouter.post("/register", authController.register);
export { authRouter };
