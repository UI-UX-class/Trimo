const db = require("../config/db.js");

async function showTrip(req) {
    console.log("Dao In");
    return new Promise((resolve, reject) => {
        var queryData = `SELECT title, contents, country, domestic, start_date, end_date, time, image_first, image_second, days, trip_place FROM travel WHERE travel_id=${req.travel_id}`;
        db.query(queryData, (error, db_data) => {
            if(error) {
                logger.error(
                    'DB error [tripList]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                )
                reject("DB ERR");
            }
            resolve(db_data);
            console.log("Dao out");
        })
    })
}

async function recentTrip(req){
    console.log("Dao In");
    return new Promise((resolve, reject) => {
        var queryData = `SELECT title, contents, country, domestic, start_date, end_date, time, image_first, image_second, days, trip_place FROM travel WHERE user_id = ${req.user_id} AND time = (SELECT MAX(time) FROM travel WHERE user_id = ${req.user_id})`;
        db.query(queryData, (error, db_data) => {
            if(error) {
                logger.error(
                    'DB error [tripList]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                )
                reject("DB ERR");
            }
            resolve(db_data);
            console.log("Dao out");
        })
    })
}

async function showTripListYear(req) {
    console.log("Dao In");
    return new Promise((resolve, reject) => {
        var queryData = `SELECT title, country, start_date, end_date, image_first FROM travel WHERE YEAR(start_date) = ${req.year} AND user_id = ${req.user_id}`;
        db.query(queryData, (error, db_data) => {
            if(error) {
                logger.error(
                    'DB error [tripList]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                )
                reject("DB ERR");
            }
            resolve(db_data);
            console.log("Dao out");
        })
    })
}

module.exports = {
    showTrip,
    recentTrip,
    showTripListYear,
}