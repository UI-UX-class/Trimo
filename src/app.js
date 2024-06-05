const express = require("express");
const app = express();
const db = require("./config/db.js");
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({extended: false}));


var loginRouter = require('./routes/loginRoutes');
const tripRouter = require('./routes/showTripRoutes');
const tripYearRouter = require('./routes/showTripYearRoutes');
const postTripRouter = require('./routes/postTripRoutes');
const deleteTripRouter = require('./routes/deleteTripRoutes');
const updateTripRouter = require('./routes/updateTripRoutes');

app.use('/user', loginRouter);
app.use('/getnote', tripRouter);
app.use('/getYearsNote', tripYearRouter);
app.use('/newnote', postTripRouter);
app.use('/delnote', deleteTripRouter);
app.use('/updatenote', updateTripRouter);

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});

module.exports = app;