const db = require("../config/db");

async function showTripListYear(idx, req){
    console.log("show year dao in");
    return new Promise((resolve, reject) => {
        var queryData = `SELECT travel_id, title, country, start_date, end_date, image_first FROM travel
        WHERE YEAR(start_date) = ${req.year} AND user_id = ${idx}`;
        db.query(queryData, (error, db_data) => {
            if(error) {
                console.error(queryData + "\n" + "show list DB Error [travel]");
                reject("DB ERR");
            }
            else {
            console.log('show list Success ▶\t' + idx + " 성공\n");
            resolve(db_data);
            }
        })
    })
}

module.exports = {
    showTripListYear,
}