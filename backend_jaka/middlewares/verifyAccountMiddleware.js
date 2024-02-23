import { supabaseClient } from "../models/supabaseClient.js";
import { responseType } from "../types/responseType.js";

const verifyToken = async (token) => {
  const { data, error } = await supabaseClient
    .from("account_sessions")
    .select("token")
    .eq("token", token);

  if (!data || data.length === 0) {
    return false;
  }

  return true;
};

const verifyAccount = async (req, res, next) => {
  const authHeader = req.headers["authorization"];
  if (!authHeader) {
    res.status(401).json(responseType("Unauthorized", null, true));
    return;
  }

  const [, token] = authHeader.split(" ");

  if (!token) {
    res.status(401).json(responseType("Unauthorized", null, true));
    return;
  }

  const isValidToken = await verifyToken(token);

  if (!isValidToken) {
    res.status(401).json(responseType("Unauthorized", null, true));
    return;
  }

  req.token = token;

  next();
};

const isAccountActivated = async (req, res, next) => {
  const { data, error } = await supabaseClient
    .from("account_activated")
    .select("is_activated")
    .eq("token", req.token);

  if (error) {
    res.status(500).json(responseType("Server Error", error, true));
    return;
  }

  if (!data || data.length === 0) {
    res.status(404).json(responseType("Account Not Found", null, true));
    return;
  }

  const user = data[0];

  if (user.is_activated !== true) {
    res.status(401).json(
      responseType(
        "Account is not activated!",
        {
          isActivated: user.is_activated,
        },
        true
      )
    );
    return;
  }

  next();
};

export default {
  verifyAccount,
  isAccountActivated,
};
