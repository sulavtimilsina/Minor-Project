const mongoose = require('mongoose');

//simple user schema
const DPSchema = new mongoose.Schema({
    doctor:{
        
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    },
    patient:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    }
}
,{
    timestamps:true
});




const DP = mongoose.model('DP',DPSchema);
exports.DP = DP; 
