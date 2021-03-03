var express = require("express");
var router = express.Router();
var cloudinary = require("cloudinary");

const auth = require("../middleware/auth");
const { Prescription } = require("../models/prescription");

var multer = require("multer");
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./public/images");
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  },
});

var upload = multer({ storage: storage });

//get user data
router.get("/", auth, async (req, res, next) => {
  let userId = req.user._id;
  let records = await Prescription.find({ user: userId });
  console.log(records);
  res.send(records);
});

//post user data
router.post("/", auth, upload.single("dataImage"), async (req, res, next) => {
  console.log("your data");
  let userId = req.body.patientId;
  try {
    const fileString = req.file.path;
    console.log(fileString);
    const uploadResponse = await cloudinary.uploader.upload(fileString, {
      upload_preset: "ml_default",
    });
    console.log(uploadResponse);
    let record = new Prescription({
      user: userId,
      imageUrl: uploadResponse.url,
    });

    await record.save();
    res.sendStatus(200);
  } catch (e) {
    console.log(e);
    res.sendStatus(400);
  }
  //for multer only
  //       let record = new Record({
  //         user:userId,
  //         image:req.file.filename
  //     });

  //   await record.save();
});

module.exports = router;
