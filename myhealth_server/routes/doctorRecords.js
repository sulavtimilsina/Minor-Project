var express = require('express');
var router = express.Router();

const auth = require('../middleware/auth');
const {Doctor} = require('../models/doctor');


var multer = require('multer');
const storage = multer.diskStorage({
    destination:function(req,file,cb) {
        cb(null,'./public/images');
    },
    filename:function(req,file,cb) {
        cb(null,file.originalname);        
    }
});

var upload = multer({storage:storage});




//getting all the user records
router.get('/',auth,async(req, res, next)=> {
    //extracting current user id using auth middleware
    //let userId = req.user._id;
    //searching record of current user by id
    let records = await Doctor.find({});
    res.send(records);
});

//posting patient records
router.post('/',auth,upload.single("profileImage"),async(req,res,next)=>{
    let userId = req.user._id;
    console.log(userId);
    

    let record = new Doctor({
        user:userId,
        certificate:req.file.filename,
        speciality:req.body.speciality,
        about:req.body.about
    });

    await record.save();
    res.send("record added");
    
});

router.delete('/',auth,async(req,res,next)=>{

    await Doctor.remove({});
    res.send('record deleted');
});

//deleting the record using id

router.delete('/:id',auth,async(req,res,next)=>{
    let recordId = req.params.id;
    console.log(recordId);
    await Doctor.findByIdAndRemove({_id:recordId});
    res.send('record deleted');
});

router.get('/speciality',auth,async(req, res, next)=> {
    //extracting current user id using auth middleware
    //let userId = req.user._id;
    //searching record of current user by id
    let records = await Doctor.find({}).populate('user');
    console.log(records);
    res.send(records);
});

module.exports = router;
