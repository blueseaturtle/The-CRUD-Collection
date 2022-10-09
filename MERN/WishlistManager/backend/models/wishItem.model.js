const mongoose = require("mongoose");

const wishItemSchema = new mongoose.Schema({
  bookID: {
    type: mongoose.Schema.Types.ObjectId,
    required: false,
    ref: "books",
  },
  title: { type: String, required: true, trim: true },
  author: { type: String, required: true, trim: true },
  isbn: { type: String, required: true, trim: true },
  price: { type: Number, required: true},
  publisher: { type: String, required: true, trim: true },
  addedDate: { type: Date, required: true, trim: true },
  image: { type: String, required: true, trim: true },
  isBought: { type: Boolean, required: true, trim: true },
});

//Registering DB
const WishListItem = mongoose.model("wishitems", wishItemSchema);

module.exports = WishListItem;
