import authService from "../services/authService.js";
import { responseType } from "../types/responseType.js";

const login = async (req, res) => {
  try {
    const loginData = await authService.login(req.body);

    if (!loginData) {
      throw new Error("Login Failed, Account not found");
    }

    if (loginData.error) {
      throw new Error(loginData.error.message);
    }

    return res
      .status(200)
      .send(
        responseType(
          "Login Succesfully",
          { token: loginData.token, user: loginData.user },
          false
        )
      );
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const register = async (req, res) => {
  try {
    const error = await authService.register(req.body);

    if (error) {
      throw new Error("Failed Register, Server Problem");
    }

    return res
      .status(200)
      .send(responseType("Register Successfully", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const logout = async (req, res) => {
  try {
    const { data, error } = await authService.logout(req.token);

    if (error) {
      throw new Error("Logout failed");
    }

    return res
      .status(200)
      .send(responseType("Logout Succesfully", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const uploadKtm = async (req, res) => {
  try {
    const { error } = await authService.uploadKtm(req.file, req.body);

    if (error) {
      throw new Error("Upload KTM failed");
    }

    return res
      .status(200)
      .send(responseType("Upload KTM Succesfully", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

const verifyOtp = async (req, res) => {
  try {
    if (!req.body.type) {
      throw new Error("Type is not defined!");
    }

    const { error } = await authService.verifyOtp(req.body);

    if (error) {
      throw new Error(error);
    }

    return res
      .status(200)
      .send(responseType("Verify OTP Succesfully", null, false));
  } catch (err) {
    return res.status(400).send(responseType(err.message, null, true));
  }
};

export default {
  login,
  register,
  logout,
  uploadKtm,
  verifyOtp,
};
