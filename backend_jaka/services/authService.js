import { supabaseClient } from "../models/supabaseClient.js";
import { compare, hash } from "bcrypt";
import * as dotenv from "dotenv";
import randomInteger from "random-int";
import uploadHelper from "../helper/uploadHelper.js";
import messageHelper from "../helper/messageHelper.js";
import { v4 } from "uuid";
dotenv.config();

const login = async (x) => {
  try {
    let queryBuilder;
    switch (x.type) {
      case "user":
        queryBuilder = supabaseClient
          .from("users")
          .select(
            "id, email, password, phone, name, nim, is_problem, is_activated"
          );
        break;
      case "penjamu":
        queryBuilder = supabaseClient
          .from("penjamus")
          .select(
            "id, email, password, phone, name, nim, is_problem, is_activated"
          );
        break;
      case "merchant":
        queryBuilder = supabaseClient
          .from("merchants")
          .select(
            "id, name, phone, address, description, lat, lng, is_problem, is_activated, otp, password"
          );
        break;
      default:
        throw new Error("Invalid user type");
    }

    let data, error;
    if (x.type === "merchant" || x.type === "penjamu") {
      ({ data, error } = await queryBuilder.eq("phone", x.phone.toString()));
    } else {
      ({ data, error } = await queryBuilder.eq("email", x.email));
    }

    if (error) {
      return { error: error };
    }

    if (!data || data.length === 0) {
      return null;
    }

    const user = data[0];

    const isEqualPassword = await compare(x.password, user.password);

    if (!isEqualPassword) {
      throw new Error("Failed Login, Email or Password is wrong!");
    }

    user.password = undefined;

    const token = await supabaseClient
      .from("account_sessions")
      .upsert({
        id: user.id,
        type: x.type,
        status: "logged",
        token: v4(),
      })
      .select("token");

    if (token.error) {
      return { error: token.error };
    }

    return {
      token: token.data[0].token,
      user: user,
      error: null,
    };
  } catch (err) {
    console.log(err.message);
    return { error: err.message };
  }
};

const register = async (data, file = null) => {
  try {
    let err;

    const hashedPassword = await hash(
      data.password,
      parseInt(process.env.SALT_ROUND_BCRYPT)
    );

    const otp = randomInteger(100000, 999999);

    if (data.type === "user") {
      err = await supabaseClient.from("users").insert({
        name: data.name,
        nim: data.nim,
        phone: data.phone,
        email: data.email,
        password: hashedPassword,
        otp: otp,
      });
    }

    if (data.type === "penjamu") {
      err = await supabaseClient.from("penjamus").insert({
        name: data.name,
        nim: data.nim,
        phone: data.phone,
        email: data.email,
        password: hashedPassword,
        otp: otp,
      });
    }

    if (data.type === "merchant") {
      err = await supabaseClient.from("merchants").insert({
        name: data.name,
        phone: data.phone,
        password: hashedPassword,
        address: data.address,
        lat: parseFloat(data.lat),
        lng: parseFloat(data.lng),
        otp: otp,
        image_url:
          "https://www.ardecokaryaglobal.com/wp-content/uploads/2015/09/akg-photo-dapur-coklat-pekan-baru1.jpg",
      });
    }

    const { error } = err;
    if (!error) {
      await messageHelper.sendOtpToWhatsapp(otp, data.phone);
    }

    return error;
  } catch (err) {
    return err;
  }
};

const logout = async (token) => {
  try {
    return await supabaseClient
      .from("account_sessions")
      .update({
        status: null,
        token: null,
      })
      .eq("token", token);
  } catch (err) {
    return { error: err.message };
  }
};

const uploadKtm = async (file, data) => {
  try {
    const image = await uploadHelper.uploadImage(file);

    const { error } = await supabaseClient
      .from("penjamus")
      .update({
        ktm: image.url,
      })
      .eq("nim", data.nim);

    return error;
  } catch (err) {
    return { error: err.message };
  }
};

const verifyOtp = async (x) => {
  try {
    let query = supabaseClient.from(`${x.type}s`).select("otp");

    if (x.type === "merchant") {
      query = query.eq("phone", x.phone);
    } else {
      query = query.eq("nim", x.nim).neq("is_activated", true);
    }

    const { data, error } = await query;
    if (error) {
      return { error: error };
    }

    if (!data || data.length === 0) {
      throw new Error("Account not found or already activated!");
    }

    const user = data[0];

    if (user.otp != x.otp) {
      throw new Error("OTP is not correct!");
    }

    // let updatingBuilder = supabaseClient.from(`${x.type}s`).update({
    //   is_activated: true,
    // });

    // if (x.type === "merchant") {
    //   updatingBuilder = query.eq("phone", x.phone);
    // } else {
    //   updatingBuilder = query.eq("nim", x.nim);
    // }

    // const updating = await updatingBuilder;

    // if (updating.error) {
    //   return { error: updating.error };
    // }

    // let accountBuilder = supabaseClient.from(`${x.type}s`).select();

    // if (x.type === "merchant") {
    //   accountBuilder = query.eq("phone", x.phone);
    // } else {
    //   accountBuilder = query.eq("nim", x.nim);
    // }

    // const account = await accountBuilder;
    // console.log(account);
    // const datAcun = account.data[0];
    // datAcun.type = x.type;

    return { error: error };

    return await login(datAcun);
  } catch (err) {
    return { error: err.message };
  }
};

const accept = async (id, data) => {
  try {
    const { error } = await supabaseClient
      .from(`${data.type}s`)
      .update({
        is_verified: true,
      })
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

const decline = async (id, data) => {
  try {
    const { error } = await supabaseClient
      .from(`${data.type}s`)
      .update({
        is_verified: false,
      })
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

const deactivate = async (id, data) => {
  try {
    const { error } = await supabaseClient
      .from(`${data.type}s`)
      .update({
        is_activated: false,
      })
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

const activate = async (id, data) => {
  try {
    const { error } = await supabaseClient
      .from(`${data.type}s`)
      .update({
        is_activated: true,
      })
      .eq("id", id);

    return error;
  } catch (err) {
    return err;
  }
};

const checkVerify = async (x) => {
  try {
    const { data, error } = await supabaseClient
      .from(`penjamus`)
      .select("is_verified")
      .eq("nim", x.nim);

    if (error) {
      return { error: error };
    }

    if (!data || data.length === 0) {
      return null;
    }

    const user = data[0];

    return user;
  } catch (err) {
    return err;
  }
};

export default {
  login,
  register,
  logout,
  uploadKtm,
  verifyOtp,
  accept,
  decline,
  deactivate,
  activate,
  checkVerify,
};
