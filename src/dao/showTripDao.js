const db = require("../config/db.js");

async function showTrip(req) {
    console.log("Dao In");
    return new Promise((resolve, reject) => {
        var queryData = `SELECT title, contents, country, domestic, start_date, end_date, time, image_first, image_second, days, trip_place FROM travel WHERE travel_id= ${req.trip_id}`;
        db.query(queryData, (error, db_data) => {
            if (error) {
                console.error(
                    'DB error [tripList]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                );
                reject("DB ERR");
            }
            resolve(db_data);
            console.log("Dao out");
        });
    });
}

async function recentTrip(idx) {
    console.log("Dao In");
    return new Promise((resolve, reject) => {
        var queryData = `SELECT title, country, travel_id, start_date, end_date FROM travel WHERE user_id = ${idx} ORDER BY time DESC LIMIT 1`;
        db.query(queryData, (error, db_data) => {
            if (error) {
                console.error(
                    'DB error [travel]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                );
                reject("DB ERR");
            }
            resolve(db_data);
        });
    });
}

// 새로운 함수 추가
async function getTripById(id) {
    console.log("Dao In - GetTripById");
    return new Promise((resolve, reject) => {
        var queryData = `SELECT * FROM travel WHERE travel_id = ${id}`;
        db.query(queryData, (error, db_data) => {
            if (error) {
                console.error(
                    'DB error [getTripById]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                );
                reject("DB ERR");
            }
            resolve(db_data);
            console.log("Dao out");
        });
    });
}

module.exports = {
    showTrip,
    recentTrip,
    getTripById // 새로운 함수 추가
};