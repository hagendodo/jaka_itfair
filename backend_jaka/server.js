import express from "express";
import bodyParser from "body-parser";
import * as dotenv from "dotenv";
import { productRouter } from "./routers/productRouter.js";
import { merchantRouter } from "./routers/merchantRouter.js";
import { penjamuRouter } from "./routers/penjamuRouter.js";
import { authRouter } from "./routers/authRouter.js";
import { cartRouter } from "./routers/cartRouter.js";
import { penjamuActivityRouter } from "./routers/penjamuActivityRouter.js";
dotenv.config();

const app = express();

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: false,
  })
);

app.use("/api/v1/merchants", merchantRouter);
app.use("/api/v1/products", productRouter);
app.use("/api/v1/penjamus", penjamuRouter);
app.use("/api/v1/penjamu-activities", penjamuActivityRouter);
app.use("/api/v1/auth", authRouter);
app.use("/api/v1/carts", cartRouter);

app.get("/", async (req, res) => {
  res.status(200).json({
    message: "Hehe",
  });
});

const port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log(`Server is listening at port ${port}`);
});
