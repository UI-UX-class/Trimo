const db = require("../config/db.js");

async function postTrip(data, postData) {
    return new Promise((resolve, reject) => {
        var queryData = `INSERT INTO travel (user_id, title, contents, country, domestic, start_date, end_date, days, time, image_first, image_second, trip_place)
                         VALUES (${postData.user_id}, '${data.title}', '${data.contents}', '${data.country}', ${data.domestic ? 1 : 0}, 
                         '${data.start_date}', '${data.end_date}', '${data.days}', '${postData.time}','${data.image_first}', '${data.image_second}', '${postData.trip_place}')`;
        db.query(queryData, (error, db_data) => {
            if (error) {
                console.error(
                    'DB error [postTrip]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                );
                return reject("DB ERR");
            }
            resolve(db_data.insertId);
            console.log("Dao out");
        });
    });
}

module.exports = {
    postTrip
};