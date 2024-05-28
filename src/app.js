const express = require("express");
const app = express();
const db = require("./config/db.js");
const port = 3000;

var loginRouter = require('./routes/loginRoutes');

app.use(express.json());
app.use(express.urlencoded({extended: false}));

app.use('/user', loginRouter);

app.listen(port, () => {
    console.log('Server running at 3000 Port !');
})