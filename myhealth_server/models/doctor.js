const mongoose = require('mongoose');

//simple user schema
const DoctorSchema = new mongoose.Schema({
    user:{
        
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    },
    certificate:{
        type:String,
        required:true
    },
    speciality:{
        type:String,
        required:true
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
