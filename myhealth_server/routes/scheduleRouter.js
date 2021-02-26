var express = require("express");
const auth = require("../middleware/auth");
const { Schedule } = require("../models/schedule");
const { User } = require("../models/user");
var router = express.Router();
const {cloudinary} = require('../utils/cloudinary');
var pdf = require("pdf-creator-node");
var fs = require("fs");

// Read HTML Template
var html = fs.readFileSync("./views/tempelate.html", "utf8");

//get all the schedule of specific doctor
router.get("/", auth, async (req, res, next) => {
  //extracting current user id using auth middleware
  let userId = req.user._id;
  //searching record of current user by id
  let records = await Schedule.find({ doctor: userId }).populate(['doctor','patient']);
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
    patient:null 
  });

  await schedule.save();
  res.send("schedule added");
});

//delete all schedule
router.delete("/",auth, async (req, res) => {

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
  var options = {
    format: "A3",
    orientation: "portrait",
    border: "10mm",
    header: {
      height: "45mm",
      contents: '<div style="text-align: center;">Author: Shyam Hajare</div>',
    },
    footer: {
      height: "28mm",
      contents: {
        first: "Cover page",
        2: "Second page", // Any page number is working. 1-based index
        default:
          '<span style="color: #444;">{{page}}</span>/<span>{{pages}}</span>', // fallback value
        last: "Last Page",
      },
    },
  };
  var userDetail = {
    username: user.username,
    email: user.email,
    startTime: result.startTime,
    endTime: result.endTime,
    data: result.date,
  };
  var document = {   
    html: html,
    data: {
        users: userDetail
    },
    path: `./${userDetail.username}.pdf`
};
pdf.create(document, options)
.then(result => {
    //console.log(res.filename);
    res.send(result.filename);
    cloudinary.uploader.upload(result.filename,{
      upload_preset:'ml_default'
    }).then(uploadResponse=>{
      console.log(uploadResponse.url)
      //res.send(uploadResponse.url)
    });
    
    //res.sendStatus(200);
})
.catch(error => {
    console.error(error)
});

});

router.delete("/remove/delete/:id",auth, async (req, res) => {
  try{
    let scheduleId = req.params.id;
    console.log(scheduleId);
    let response = await Schedule.findByIdAndDelete(scheduleId);
    console.log(response);
    res.sendStatus(200);
  }catch{
    res.sendStatus(400);
  }

});

module.exports = router;
