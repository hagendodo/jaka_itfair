import express from "express";
import bodyParser from "body-parser";
import * as dotenv from "dotenv";
import { productRouter } from "./routers/productRouter.js";
import { merchantRouter } from "./routers/merchantRouter.js";
import { penjamuRouter } from "./routers/penjamuRouter.js";
import { authRouter } from "./routers/authRouter.js";
import { cartRouter } from "./routers/cartRouter.js";
import { penjamuActivityRouter } from "./routers/penjamuActivityRouter.js";
import { userRouter } from "./routers/userRouter.js";
import { orderRouter } from "./routers/orderRouter.js";
import { supabaseClient } from "./models/supabaseClient.js";
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
app.use("/api/v1/users", userRouter);
app.use("/api/v1/penjamu-activities", penjamuActivityRouter);
app.use("/api/v1/auth", authRouter);
app.use("/api/v1/carts", cartRouter);
app.use("/api/v1/orders", orderRouter);

app.get("/", async (req, res) => {
  const { data, error } = await supabaseClient
    .from("orders")
    .select(
      "id, total, detail_products(id, products(id, name), price, quantity) "
    )
    .eq("id", "f96cbd2a-abfe-42cb-bf25-b06228da5329");

  res.status(200).json({
    message: data,
  });
});

const port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log(`Server is listening at port ${port}`);
});
