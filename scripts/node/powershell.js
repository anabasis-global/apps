let path = require('path'), 
    fs = require('fs'),
    spawn = require("child_process").spawn,
    child;


let appsPath = path.resolve('C:\\IT\Apps')
file = ""

child = spawn("powershell.exe",[file]);

child.stdout.on("data",function(data){
    console.log("Powershell Data: " + data);
});
child.stderr.on("data",function(data){
    console.log("Powershell Errors: " + data);
});

child.on("exit",function(){
    console.log("Powershell Script finished");
});

child.stdin.end(); //end input


module.exports = child
