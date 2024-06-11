const db = require("../config/db.js");

async function deleteTrip(travel_id) {
    return new Promise((resolve, reject) => {
        var queryData = `delete from travel where travel_id=${travel_id}`;
        db.query(queryData, (error, db_data) => {
            if (error) {
                console.error(queryData + "\n" + "delete trip DB Error [travel]");
                reject("DB ERR")
            }
            resolve(db_data);
        });
    });
}

module.exports = {
    deleteTrip
};