var express = require('express'),
  app = express(),
  bodyParser = require('body-parser'),
  mongoose = require('mongoose');

mongoose.Promise = global.Promise;
mongoose.connect('mongodb://localhost/test');

var User = mongoose.model('User', { name: String, email: String });

app.use(bodyParser.json());

app.post('/api/v1/user', function (req, res) {
  console.log(req.url, req.body);
  User.create(req.body)
    .then(function (user) {
      res.json(user);
    })
    .catch(function (err) {
      res.status(400, {errcode: 1, errmsg: err.message});
    });
});

app.post('/api/v1/user/:id', function (req, res) {
  console.log(req.url, req.body);
  User.update({_id: req.params.id}, req.body)
    .then(function (user) {
      console.log(user);
      res.json(user);
    })
    .catch(function (err) {
      res.status(400, {errcode: 1, errmsg: err.message});
    });
});

app.get('/api/v1/user', function (req, res) {
  console.log(req.url);
  User.find({})
    .lean()
    .sort({_id: 1})
    .then(function (users) {
      res.json({users: users});
    })
    .catch(function (err) {
      res.status(400).json({errcode: 2, errmsg: err.message});
    });
});

app.get('/api/v1/user/:id', function (req, res) {
  console.log(req.url);
  User.findOne({_id: req.params.id})
    .then(function (user) {
      res.json(user);
    })
    .catch(function (err) {
      res.status(404).json({errcode: 3, errmsg: err.message});
    });
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});