var express = require('express');
var app = express();
var port = 80;

app.use(express.static('app'));

app.listen(port, () => {
    console.log("App running on port " + port);
});
