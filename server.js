var express = require('express');
var bodyParser = require('body-parser');
var app_api = express();
var app_www = express();

app_api.all('/*', function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With");
  next();
});

// API 서버 구동
app_api.use(bodyParser.urlencoded({ extended: true }));
app_api.use(express.json());
app_api.use('/Statistics', require('./api/Statistics'));
app_api.listen(3000, function () {
  console.log('API 서버 구동 완료 : PORT 3000');
});

app_www.use(express.static(__dirname + "/www/"));
app_www.listen(80, function () {
  console.log('WWW 서버 구동 완료 : PORT 80');
});
