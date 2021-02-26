const mongoose = require("mongoose");

//simple user schema
const ShopSchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    products: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
      },
    ],
  },
  {
    timestamps: true,
  }
);

const Shop = mongoose.model("Shop", ShopSchema);
exports.Shop = Shop;
