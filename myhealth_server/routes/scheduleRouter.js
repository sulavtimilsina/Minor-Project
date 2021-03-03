var express = require("express");
const auth = require("../middleware/auth");
const { Schedule } = require("../models/schedule");
const { User } = require("../models/user");
var router = express.Router();
const { cloudinary } = require("../utils/cloudinary");
//var pdf = require("pdf-creator-node");
var fs = require("fs");
let ejs = require("ejs");
let pdf = require("html-pdf");
let path = require("path");

//get all the schedule of specific doctor
router.get("/", auth, async (req, res, next) => {
  //extracting current user id using auth middleware
  let userId = req.user._id;
  //searching record of current user by id
  let records = await Schedule.find({ doctor: userId }).populate([
    "doctor",
    "patient",
  ]);
  console.log(records);
  res.send(records);
});

// //get all the schedule of specific doctor
// router.get('/', async(req, res, next)=> {
//   let records = await Schedule.find({}).populate('patient');
//   console.log(records);
//   res.send(records);
// });

//creating schedule by doctor

router.post("/", auth, async (req, res, next) => {
  //userID of doctor from auth
  let doctorId = req.user._id;

  let schedule = new Schedule({
    doctor: doctorId,
    startTime: req.body.startTime,
    endTime: req.body.endTime,
    date: req.body.date,
    patient: null,
  });

  await schedule.save();
  res.send("schedule added");
});

//delete all schedule
router.delete("/", auth, async (req, res) => {
  await Schedule.remove({});
  res.send(true);
});

//get appointment of specific doctor

router.get("/appointment/:doctorId", auth, async (req, res) => {
  let doctorId = req.params.doctorId;
  let appointment = await Schedule.find({ doctor: doctorId });
  //console.log(appointment);
  res.send(appointment);
});

//patient making appointment

router.post("/appointment", auth, async (req, res) => {
  let patietId = req.user._id;
  let scheduleId = req.body.scheduleId;
  let user = await User.findById(patietId);
  //console.log("This is user");
  //console.log(user.username);

  //console.log(scheduleId);
  //console.log(patietId);
  //let record = await Schedule.findById(scheduleId)
  let result = await Schedule.findByIdAndUpdate(scheduleId, {
    patient: patietId,
  });
  var userDetail = {
    username: user.username,
    email: user.email,
    startTime: result.startTime,
    endTime: result.endTime,
    data: result.date,
  };
  
  ejs.renderFile(
    path.join(__dirname, "../views/", "template.ejs"),
    { students: userDetail },
    (err, data) => {
      console.log("befor test");
      if (err) {
        console.log(err);
        res.send(err);
      } else {
        let options = {
          height: "11.25in",
          width: "8.5in",
          header: {
            height: "20mm",
          },
          footer: {
            height: "20mm",
          },
        };
        console.log("No error");
        console.log(options);
        pdf.create(data, options).toFile("report.pdf", function (err, data) {
          if (err) {
            res.send(err);
          } else {
            console.log(data);
            console.log("File created successfully");
            res.send("File created successfully");
          }
        });
      }
    }
  );
});


router.delete("/remove/delete/:id", auth, async (req, res) => {
  try {
    let scheduleId = req.params.id;
    console.log(scheduleId);
    let response = await Schedule.findByIdAndDelete(scheduleId);
    console.log(response);
    res.sendStatus(200);
  } catch {
    res.sendStatus(400);
  }
});

module.exports = router;
