var express = require('express');
const auth = require('../middleware/auth');
const { Schedule } = require('../models/schedule');
var router = express.Router();

//get all the schedule of specific doctor
router.get('/',auth, async(req, res, next)=> {
  //extracting current user id using auth middleware
  let userId = req.user._id;
  //searching record of current user by id
  let records = await Schedule.find({doctor:userId});
  console.log(records);
  res.send(records);
});


//creating schedule by doctor

router.post('/',auth,async(req,res,next)=>{
  //userID of doctor from auth
    let doctorId = req.user._id;

    let schedule = new Schedule({
        doctor:doctorId,
        startTime:req.body.startTime,
        endTime:req.body.endTime,
        date:req.body.date,
    });

    await schedule.save();
    res.send("schedule added");
    
});

//patient making appointment


module.exports = router;