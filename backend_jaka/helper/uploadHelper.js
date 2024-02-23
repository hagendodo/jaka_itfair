import {
  getStorage,
  ref,
  getDownloadURL,
  uploadBytesResumable,
} from "firebase/storage";
import { firebaseClient } from "../models/firebaseClient.js";
import { giveCurrentDateTime } from "./generalHelper.js";

firebaseClient();

const storage = getStorage();

const uploadImage = async (file) => {
  try {
    const dateTime = giveCurrentDateTime();

    const storageRef = ref(
      storage,
      `files/${file.originalname + "       " + dateTime}`
    );

    const metadata = {
      contentType: file.mimetype,
    };

    const snapshot = await uploadBytesResumable(
      storageRef,
      file.buffer,
      metadata
    );

    const downloadURL = await getDownloadURL(snapshot.ref);

    console.log(file);

    const image = {
      name: file.originalname,
      type: file.mimetype,
      url: downloadURL,
    };

    return image;
  } catch (error) {
    return null;
  }
};

export default {
  uploadImage,
};
