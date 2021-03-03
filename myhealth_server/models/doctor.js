const mongoose = require('mongoose');

//simple user schema
const DoctorSchema = new mongoose.Schema({
    user:{

        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    },
    fullname:{
    type:String,
    require:true
    },
    eduction:{
    type:String,
    require:true
    },
    certificate:{
        type:String,
        required:true
    },
    speciality:{
        type:String,
        required:true
    },
    nmc:{
        type:String,
        required:true
    },
    experience:{
         type:String,
          required:true
    },
//    profileImage:{
//         type:String,
//         required:true
//    },
    dob:{
        type:String,
        required:true
    },
    contact:{
         type:String,
         required:true
    },
    address:{
         type:String,
         required:true
     },
    blood:{
        type:String,
        require:true
    },
    about:{
        type:String,
        required:true
    }
}
,{
    timestamps:true
});



const Doctor = mongoose.model('Doctor',DoctorSchema);
exports.Doctor = Doctor; 
