var express = require('express');
const auth = require('../middleware/auth');
var router = express.Router();
const {DP} = require('../models/doctorsPatient');

/* GET home page. */
router.get('/', auth,async(req, res, next) =>{
  let doctor = req.user._id;
  let records = await DP.find({doctor:doctor}).populate(['patient','doctor']);
  console.log(records);
  
  res.send(records);
});
router.post('/',auth, async(req, res, next) =>{
    let doctor = req.user._id;
    let patient = new DP({
        doctor:doctor,
        patient:req.body.patientId
    });
    
    await patient.save();
    res.sendStatus(200);
  });

  router.delete('/',async(req,res)=>{
    await DP.remove();
    res.send(true);
  });

module.exports = router;
