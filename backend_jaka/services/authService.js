import { supabaseClient } from "../models/supabaseClient.js";
import { compare, hash } from "bcrypt";
import * as dotenv from "dotenv";
import randomInteger from "random-int";
import uploadHelper from "../helper/uploadHelper.js";
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
            "id, name, address, description, lat, lng, is_problem, is_activated, otp, password"
          );
        break;
      default:
        throw new Error("Invalid user type");
    }

    let data, error;
    if (x.type === "merchant" || x.type === "penjamu") {
      ({ data, error } = await queryBuilder.eq("phone", x.phone));
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

const sendOtpToWhatsapp = async (otp) => {
  console.log("HEREss");
  const config = {
    method: "POST",
    headers: {
      Authorization: `Bearer ${process.env.ACCESS_TOKEN}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      messaging_product: "whatsapp",
      preview_url: false,
      recipient_type: "individual",
      to: recipient,
      type: "text",
      text: {
        body: `🔐 **Kode Verifikasi Anda**

        Halo,\n\nSilakan gunakan kode verifikasi ini untuk menyelesaikan pendaftaran Anda:\n\n**${otp}**
        
        Pastikan untuk tidak membagikan kode ini kepada siapa pun demi keamanan akun Anda. Jika Anda tidak meminta kode ini, silakan abaikan pesan ini.
        
        Terima kasih,\nJaka Corp.
        `,
      },
    }),
  };

  const url = `https://graph.facebook.com/${process.env.VERSION}/${process.env.PHONE_NUMBER_ID}/messages`;
  console.log("HERE1");
  try {
    const response = await fetch(url, config);
    console.log("HERE2");
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    console.log("HERE3");
    return await response.json();
  } catch (error) {
    console.error("Error:", error);
    throw error;
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
        lat: data.lat,
        lng: data.lng,
        otp: otp,
      });
    }

    const { error } = err;
    // if (!error) {
    //   console.log("HERE0");
    //   await sendOtpToWhatsapp(otp);
    // }

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
      .from("penjamu")
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
      query = query.eq("phone", x.phone).neq("is_activated", true);
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

    const updating = await supabaseClient
      .from(`${x.type}s`)
      .update({
        is_activated: true,
      })
      .eq("nim", x.nim);

    if (updating.error) {
      return { error: updating.error };
    }

    return { error: error };
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
};
