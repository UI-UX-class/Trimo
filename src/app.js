const express = require("express");
const app = express();
const db = require("./config/db.js");
const port = 3000;

var loginRouter = require('./routes/loginRoutes');

app.use(express.json());
app.use(express.urlencoded({extended: false}));


const tripRouter = require('./routes/showTripRoutes');
const tripYearRouter = require('./routes/showTripYearRoutes');
const postTripRouter = require('./routes/postTripRoutes');
const deleteTripRouter = require('./routes/deleteTripRoutes');

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use('/user', loginRouter);
app.use('/getnote', tripRouter);
app.use('/getYearsNote', tripYearRouter);
app.use('/newnote', postTripRouter);
//app.use('/delnote', deleteTripRouter);

app.listen(port, () => {
    console.log('Server running at http://localhost:${port}/');
});

module.exports = app;