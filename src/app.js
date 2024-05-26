const express = require("express");
const app = express();
const db = require("/Users/irmac/Desktop/승희/Trimo/src/config/db.js");
const port = 3000;

app.get('/', (req, res) => {
    res.send('Hello World!');
})

// DB Test
db.getConnection((error, connection) => {
    connection.query('SELECT * FROM user', (error, result, fields) => {
    if(!error) {
        console.log(result)
        connection.release()
    } else {
        throw error
    }
})})

app.listen(port, () => {
    console.log('Server running at 3000 Port !');
})