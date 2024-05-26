const express = require("express");
const app = express();
const db = require("./config/db.js");
const port = 3000;

var tripRouter = require('./routes/showTripRoutes');
var tripYearRouter = require('./routes/showTripYearRoutes');
var postTripRouter = require('./routes/postTripRoutes');

app.use(express.json());
app.use(express.urlencoded({extended: false}));

app.use('/getnote', tripRouter);
app.use('/getYearsNote', tripYearRouter);
app.use('/newnote', postTripRouter);


app.listen(port, () => {
    console.log('Server running at 3000 Port !');
});

module.exports = app;