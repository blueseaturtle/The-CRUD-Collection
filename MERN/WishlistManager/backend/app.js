const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");

require("dotenv").config();
const app = express();
const port = process.env.PORT || 6060;
app.use(cors());
app.use(express.json());

const url = process.env.ATLAS_URI;
global.URL = url;
mongoose.connect(url, {
  useNewUrlParser: true,
  useCreateIndex: true,
  useUnifiedTopology: true,
});

const connection = mongoose.connection;

connection.once("open", () => {
  console.log("MongoDB connected successfully");
});

app.get("/", (req, res) => {
  res.send("Running Successfully");
});

const wishlistAPI = require("./api/wishlist.api");
app.use("/wishlist", wishlistAPI());

app.listen(port, () => {
  console.log(`Server is running on port: ${port}`);
});
