var express = require('express'),
    app = express();

// a middleware with no mount path; gets executed for every request to the app
app.use(function(req, res, next) {
    console.log('Time:', Date.now());
    next();
});

app.get('/', function(req, res) {
    res.send('NodeJs version ' + process.version);
});

var server = app.listen(3000, function() {
    var port = server.address().port;
    console.log('Listening at port:' + port);
})
