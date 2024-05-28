const db = require("../config/db.js");

async function showTripListYear(req){
    console.log("Dao In");
    return new Promise((resolve, reject) => {
        var queryData = `SELECT travel_id, title, country, start_date, end_date, image_first FROM travel WHERE YEAR(start_date) = 2003 AND user_id = 1`;
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
    showTripListYear,
}