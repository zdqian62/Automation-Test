var express = require('express');
var app = express();
var MongoClient = require('mongodb').MongoClient;
var hosturl = "mongodb://localhost:xxxx/";
var fs = require('fs');
var http = require('http');
var url = require('url');

var documentRoot = '/Users/zhengdongqian/Documents/ANXINintern/rfautotest/interfacetest/interfaceoutput/';

app.set('views', './views');
app.set('view engine', 'jade');
app.engine('jade', require('jade').__express);

app.get('', function (req, res) {
	MongoClient.connect(hosturl, function(err, db) {
    	if (err) throw err;
    	var dbo = db.db("robot");
    	dbo.collection("autotest_activity").find().toArray(function(err, result) {
        	if (err) throw err;
        	console.log(result.length);
        	//console.log(result);
            total = 0;
            passed = 0;
            failed = 0;
        	for (var i = 0; i < result.length; i++){
                console.log(result[i]["log"]);
        		logfile = result[i]["log"];
                total += parseInt(result[i]["total"]);
                passed += parseInt(result[i]["passed"]);
                failed += parseInt(result[i]["failed"]);
        	}
            console.log(passed/total)
            location = documentRoot + result[0]["log"]
            res.render('splitpage', {data:result, total:total, passed:passed/total*100});
        	db.close();
    	});
	});
})

app.get('/logfile', function (req, res) {
    var arg = url.parse(decodeURI(req.url),true).query;
    console.log(arg.filename);
    var file = documentRoot + arg.filename + ".html";
    fs.readFile( file, function(err, data){
        res.end(data);
    })
})

var server = app.listen(8083, function () {

  var host = server.address().address
  var port = server.address().port

  console.log("应用实例，访问地址为 http://%s:%s", host, port)

})



