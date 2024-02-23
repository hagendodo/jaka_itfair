import { initializeApp } from "firebase/app";
import config from "../config/firebaseConfig.js";

const firebaseClient = () => {
  initializeApp(config.firebaseConfig);
};

export { firebaseClient };
