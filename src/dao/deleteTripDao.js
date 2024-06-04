const db = require("../config/db.js");

async function deleteTrip(travel_id) {
    return new Promise((resolve, reject) => {
        var queryData = `delete from travel where travel_id=${travel_id}`;
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
    deleteTrip
};