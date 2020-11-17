const mongoose = require('mongoose');

//simple user schema
const ScheduleSchema = new mongoose.Schema({
    doctor:{
        
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    },
    patient:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    },
    startTime:{
        type:String,
        required:true
    },
    endTime:{
        type:String,
        required:true
    },
    date:{
        type:String,
        required:true
    }

}
,{
    timestamps:true
});




const Schedule = mongoose.model('Schedule',ScheduleSchema);
exports.Schedule = Schedule; 
