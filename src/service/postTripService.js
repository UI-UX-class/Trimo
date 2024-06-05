const postTripDao = require("../dao/postTripDao");

async function postTrip(data) {
    try {
        const details = data.trip_place;

        const detailsJSON = JSON.stringify(details);

        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1);
        const day = String(now.getDate());
        const hours = String(now.getHours());
        const minutes = String(now.getMinutes());
        const seconds = String(now.getSeconds());

        const postData = {  //따옴표가 없는데?
            user_id : 1,
            trip_place : detailsJSON,
            time : `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
        }
        const result = await postTripDao.postTrip(data, postData);
        return {
            "Message": "성공",
            "Status": 201,
            "Data": result
        };
    } catch (err) {
        return {
            "Message": "실패",
            "Status": 400,
            "Error_Message": err
        };
    }
}

module.exports = {
    postTrip
};