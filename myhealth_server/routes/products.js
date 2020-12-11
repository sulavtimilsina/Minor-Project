var express = require('express');
var router = express.Router();
const {Product} = require('../models/product');

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
  res.render('product/show');
  //res.send(products);
});
router.get('/add',(req,res)=>{
  res.render('product/add')
  //res.send(true);
});

router.post('/add',upload.single("image"),async(req,res)=>{
  console.log(req.body);
  console.log(req.file);
  let product = new Product({
    name:req.body.name,
    price:req.body.price,
    features:req.body.features,
    details:req.body.details,
    imageUrl:req.file.filename
  });
  await product.save();
  res.render('product/add')
  //res.send(true);
});
router.post('/shop',(req,res)=>{
  console.log(req.body);
});

router.get('/api',async(req,res)=>{
  let products =await Product.find({});

  res.send(products);
});



module.exports = router;
