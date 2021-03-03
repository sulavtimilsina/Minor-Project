var express = require('express');
var router = express.Router();
const bcrypt = require("bcrypt");
const { User, validate } = require("../models/user");
const Joi = require('@hapi/joi');
const auth = require('../middleware/auth');


var multer = require('multer');
const storage = multer.diskStorage({
    destination:function(req,file,cb) {
      console.log(file);
        cb(null,'./public/images');
    },
    filename:function(req,file,cb) {
        cb(null,file.originalname);        
    }
})

var upload = multer({storage:storage});

/* GET users listing. */
router.get('/', async (req, res, next)=> {
  let users =await User.find({});
  //console.log(users);
  res.send(users);
});

//register user
router.post("/",async (req,res,next)=>{
  

  //validate the request body first
  const {error} = validate(req.body);
  //console.log(error.details[0].message);
  if(error) return res.status(400).send({message:error.details[0].message});
  

  // finding existing user
  let user = await User.findOne({email:req.body.email});
  if(user) return res.status(400).send({message:'User already registered'});
  
  //create user object 
  user = new User({
      username: req.body.username,
      email: req.body.email,
      password: req.body.password,
      userType:req.body.userType
      // sex: req.body.sex,
      // dateOfBirth:req.body.dateOfBirth,
      // profileImage:req.file.filename
    });
    //hashing user password using bcrypt
     user.password = await bcrypt.hash(user.password,10);
     //console.log(user);
  try{
    //saving user object in data base
     await user.save();

     //generate authentication token
    const token = user.generateAuthToken();
    //set header with token to client using name "x-auth-token"
    //send data to client
    res.header("x-auth-token",token).send({
      _id: user._id,
      username: user.username,
      userType:user.userType
    });
    //console.log(token);
    
  }catch(error){
    res.status(400).json({ 
      error: error.toString() 
    });
  }
 });
 //delete all users
 router.delete('/',async (req,res,next)=>{
   await User.remove({});
   res.send(true);
 });
 
 router.delete('/:id',async(req,res)=>{
  let id = req.params.id;
   await User.findByIdAndRemove({id});
   res.send(true);
 })

 //login user
router.post('/login', async (req,res,next)=>{
  //validate the request body first
  const {error} = validateUser(req.body);
  console.log(validateUser(req.body));
  if(error) return res.status(400).send(error.details[0].message);

  //finding the user
  let user = await User.findOne({email:req.body.email});
  console.log(user);
  if(!user) return res.status(400).send("Invalid email or password");

  //comparing password using bcrypt
   var validPassword = await bcrypt.compare(req.body.password,user.password)

   if(!validPassword) return res.status(400).send("Invalid email or password");
  
   const token = user.generateAuthToken();
   if(user.isAdmin) res.header("x-auth-token",token).render('product/show');
   res.header("x-auth-token",token).send({
    _id: user._id,
    username: user.username,
    userType:user.userType
  });

});

//get all the doctors 
router.get('/doctors',auth, async (req, res, next)=> {
  let userId = req.user._id;
  //console.log(userId);
  let users =await User.find({userType:"doctor"});
  //console.log(users);
  res.send(users);
});
router.get('/speciality/:speciality', async (req, res, next)=> {
  let speciality = req.params.speciality;
  let users =await User.find({userType:speciality});
  //console.log(users);
  res.send(users);
});
router.get('/userDetail/:id', async (req, res, next)=> {
  let userId = req.params.id;
  let user =await User.findById(userId);
  //console.log(user); 
  res.send(user);
});


//upload profile image saperately
// router.get('/profileImage/:id',async(req,res,next)=>{
//   let userId = req.params.id
//   let user = await User.findById({_id:userId});
//   res.send({
//     profileImage:user.profileImage
//   });
// });
router.post('/profileImage',upload.single("profileImage"),async(req,res,next)=>{
  //console.log(req)
  // let userId = req.params.id
  // let user = await User.findById({_id:userId});


  res.send("file saved");
});

//function to validate user
function validateUser(req){
  const schema =Joi.object({
      email:Joi.string().min(3).max(255).required(),
      password:Joi.string().min(8).max(255).required(),
  })
  return schema.validate(req);;
}

module.exports = router;