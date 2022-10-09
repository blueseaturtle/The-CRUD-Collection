const mongoose = require("mongoose");

const wishListSchema = new mongoose.Schema({
  isPrivate: { type: Boolean, required: true, trim: true, min: 6 },
  items: [
    {
      type: mongoose.Schema.Types.ObjectId,
      required: false,
      ref: "wishitems",
    },
  ],
});

//Registering DB
const WishList = mongoose.model("wishlists", wishListSchema);

module.exports = WishList;
