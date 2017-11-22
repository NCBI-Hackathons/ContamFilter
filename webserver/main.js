var express = require('express');
var app = express();

var settings = {};
for (var i = 2; i < process.argv.length; i++) {
  if (process.argv[i] == '-open') {
    settings.open = true;
  }
}

app.use(express.static(__dirname + '/static'));

// 404 - Not Found
app.use(function(req, res, next){
  res.type('text/plain');
  res.status(404);
  res.send('404 - Not Found\n' + req.url);
});
// 500 - Server Error
app.use(function(err, req, res, next){
  console.error(err.stack);
  res.type('text/plain');
  res.status(500);
  res.send('500 - Server Error\n' + req.url);
});

// running server on the first available port from 3000 to 3010
var port = 3000;
function onsuccess() {
  var url = 'http://localhost:' + port;
  console.log('Running server at', url);
  console.log('Press Ctrl-C to stop...');
  if (settings.open) {
    var opn = require('opn');
    opn(url);
  }
}
function onerror(err) {
  if (err.code != 'EADDRINUSE' || port >= 3010) {
    throw err;
  }
  port++;
  app.set('port', port);
  app.listen(port, onsuccess).on('error', onerror);
}

app.set('port', port);
app.listen(port, onsuccess).on('error', onerror);
