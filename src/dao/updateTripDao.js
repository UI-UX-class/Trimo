const db = require("../config/db.js");

async function updateTrip(data, putData) {
    console.log("dao 들어옴");
    console.log(data);
    console.log(putData);
    return new Promise((resolve, reject) => {
        var queryData = `UPDATE travel
           SET title = '${data.title}',
           contents = '${data.contents}',
           country = '${data.country}',
           domestic = ${data.domestic ? 1 : 0},
           start_date = '${data.start_date}',
           end_date = '${data.end_date}',
           days = ${data.days},
           time = '${putData.time}',
           image_first = '${data.image_first}',
           image_second = '${data.image_second}',
           trip_place = '${putData.trip_place}'
           WHERE travel_id = ${putData.travel_id}`;

        db.query(queryData, (error, db_data) => {
            if (error) {
                console.error(
                    'DB error [updateTrip]' +
                    '\n \t' + queryData +
                    '\n \t' + error
                );
                return reject("DB ERR");
            }
            resolve(db_data.affectedRows); // 업데이트된 행의 수 반환
            console.log("Dao out");
        });
    });
}

module.exports = {
    updateTrip
};
