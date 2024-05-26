const db = require("../config/db.js");

async function postTrip(data) { // 여기서 'req' 대신 'data' 사용
    console.log("Dao In");
    return new Promise((resolve, reject) => {
        const { user_id, title, contents, country, domestic, start_date, end_date, time, image_first, image_second, trip_place } = data;

        const details = {
            trip_place: trip_place // 사용자 입력값
        };

        const detailsJSON = JSON.stringify(details);

        var queryData = `INSERT INTO travel (user_id, title, contents, country, domestic, start_date, end_date, time, image_first, image_second, trip_place)
                         VALUES (${user_id}, '${title}', '${contents}', '${country}', ${domestic ? 1 : 0}, '${start_date}', '${end_date}', '${time}', '${image_first}', '${image_second}', '${detailsJSON}')`;

        db.query(queryData, (error, db_data) => {
            if (error) {
                console.error(
                    'DB error [postTrip]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                );
                return reject("DB ERR");
            }
            resolve(db_data);
            console.log("Dao out");
        });
    });
}

module.exports = {
    postTrip
};