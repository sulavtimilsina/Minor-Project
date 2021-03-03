var express = require("express");
var router = express.Router();
const auth = require("../middleware/auth");
const {Doctor} = require("../models/doctor");

/* GET home page. */
router.post("/",async (req, res) => {
  console.log(req.body);
  var spawn = require("child_process").spawn,
    py = spawn("python", ["F:/Minor-Project/myhealth_server/routes/script.py"]),
    data = req.body;
  // data = [1,2,3,4,5,6,7,8,9],
  dataString = "";

  py.stdout.on("data", async (data) =>{
    dataString += data.toString();
     let speciality = data.toString();
    console.log(speciality);

    res.send(speciality);
  });
  py.stdout.on("end",async ()=> {
    console.log("Go to this department=", dataString);
    //let result =await Doctor.find({})
    //console.log(result);
  });
  py.stdin.write(JSON.stringify(data));
  py.stdin.end();
  //console.log(JSON.stringify(data));


  //res.send(true);
});

router.get('/find/:id',auth,async(req,res)=>{
  let speciality = req.params.id.toString();
  //let speciality = 'Dermatologist';
   //console.log(speciality);
   console.log(speciality);
   let result =await Doctor.find({speciality:speciality}).populate('user');

   console.log(result);
   res.send(result);

});


module.exports = router;
