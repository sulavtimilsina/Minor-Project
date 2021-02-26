var express = require('express');
var router = express.Router();
const {Product} = require('../models/product');
const {cloudinary} = require('../utils/cloudinary');

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

/* GET home page. */
router.get('/',async function(req, res, next) {
  let products =await Product.find({});
  res.render('product/show',{products:products});
});
router.delete('/',async (req,res,next)=>{
  await Product.remove({});
   res.send(true);
});
router.get('/add',(req,res)=>{
  res.render('product/add')
  //res.send(true);
});
//
router.post('/add',upload.single("image"),async(req,res)=>{
  // console.log(req.body);
  //console.log(req.file.path);
  try{
    const fileString = req.file.path;
    //console.log(fileString);
    const uploadResponse = await cloudinary.uploader.upload(fileString,{
      upload_preset:'ml_default'
    });
    //console.log(uploadResponse);
    let product = new Product({
      name:req.body.name,
      price:req.body.price,
      features:req.body.features,
      details:req.body.details,
      imageUrl:uploadResponse.url
    });
    
  await product.save();
  //res.render('product/add')
  res.redirect('/products');
  //res.send(true);
  }catch(e){
    console.log(e);
    res.sendStatus(400);
  }
});
router.post('/delete',async (req,res,next)=>{
  let productId = req.body.id;
  //console.log(productId);
  await Product.findByIdAndDelete(productId);
   //res.render('product/show').send(true);
   res.redirect('/products');
});

router.get('/api',async(req,res)=>{
  let products =await Product.find({});

  res.send(products);
});



module.exports = router;
