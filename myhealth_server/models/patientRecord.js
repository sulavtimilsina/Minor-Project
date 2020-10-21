const mongoose = require('mongoose');

//simple user schema
const RecordSchema = new mongoose.Schema({
    user:{
        
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    },
    image:{
        type:String,
        required:true
    }
}
,{
    timestamps:true
});



const Record = mongoose.model('Record',RecordSchema);
exports.Record = Record; 
