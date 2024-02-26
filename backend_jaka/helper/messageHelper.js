const sendOtpToWhatsapp = async (otp, recipient) => {
  const url = "https://api.fonnte.com/send";
  const token = "6rCgYLQ_Ckdh3Pg@JyxM";
  const data = {
    target: recipient,
    message: `🔐 Kode Verifikasi Anda

    Halo,
    
    Silakan gunakan kode verifikasi ini untuk menyelesaikan pendaftaran Anda:
    
    ${otp}
    
    Pastikan untuk tidak membagikan kode ini kepada siapa pun demi keamanan akun Anda. Jika Anda tidak meminta kode ini, silakan abaikan pesan ini.
    
    Terima kasih,
    Jaka Corp.
    `,
    countryCode: "62", // optional
  };

  try {
    const response = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: token,
      },
      body: JSON.stringify(data),
    });

    const responseData = await response.json();
  } catch (error) {
    console.error("Error:", error);
  }
};

const sendMessageToWhatsapp = async (recipient, message) => {
  const url = "https://api.fonnte.com/send";
  const token = "6rCgYLQ_Ckdh3Pg@JyxM";
  const data = {
    target: recipient,
    message: message,
    countryCode: "62",
  };

  try {
    const response = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: token,
      },
      body: JSON.stringify(data),
    });

    const responseData = await response.json();
  } catch (error) {
    console.error("Error:", error);
  }
};

export default {
  sendOtpToWhatsapp,
  sendMessageToWhatsapp,
};
