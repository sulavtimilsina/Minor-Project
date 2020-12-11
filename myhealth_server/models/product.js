const mongoose = require('mongoose');

//simple user schema
const ProductSchema = new mongoose.Schema({
    name:{
        type:String,
        required:true
    },
    imageUrl:{
        type:String,
        required:true
    },
    price:{
        type:String,
        required:true
    },
    details:{
        type:String,
        required:true
    },
    features:{
        type:String,
        required:true
    }
}
,{
    timestamps:true
});



const Product = mongoose.model('Product',ProductSchema);
exports.Product = Product; 
