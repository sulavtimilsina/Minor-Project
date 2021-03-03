var express = require('express');
var router = express.Router();

/* GET home page. */
router.post('/',(req,res)=>{
    console.log(req.body.data);
      var spawn = require('child_process').spawn,
      py    = spawn('python', ['F:\Minor-Project\myhealth_server\routes\script.py']),
      data = req.body.data;
      // data = [1,2,3,4,5,6,7,8,9],
      dataString = '';
  
  
      py.stdout.on('data', function(data){
    dataString += data.toString();
  });
  py.stdout.on('end', function(){
    console.log('Go to this department=',dataString);
  });
  py.stdin.write(JSON.stringify(data));
  py.stdin.end();
  console.log(JSON.stringify(data));
  
    res.send(true);
  })

module.exports = router;
