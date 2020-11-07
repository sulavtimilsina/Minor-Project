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
    let userId = req.user._id;
    //searching record of current user by id
    let records = await Doctor.findOne({user:userId});
    res.send(records);
});

//posting patient records
router.post('/',auth,upload.single("profileImage"),async(req,res,next)=>{
    let userId = req.user._id;

    let record = new Doctor({
        user:userId,
        certificate:req.file.filename,
        speciality:req.body.speciality,
        about:req.body.about
    });

    await record.save();
    res.send("record added");
    
});

//deleting the record using id

router.delete('/:id',auth,async(req,res,next)=>{
    let recordId = req.params.id;

    await Record.findByIdAndRemove({_id:recordId});
    res.send('record deleted');
});

module.exports = router;
