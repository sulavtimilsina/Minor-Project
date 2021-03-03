const mongoose = require("mongoose");

//simple user schema
const PrescriptionSchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    imageUrl: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

const Prescription = mongoose.model("Prescription", PrescriptionSchema);
exports.Prescription = Prescription;
