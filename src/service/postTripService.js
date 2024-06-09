const postTripDao = require("../dao/postTripDao");

async function postTrip(idx, data) {
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

        const postData = {
            user_id : idx,
            trip_place : detailsJSON,
            time : `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
        }
        const result = await postTripDao.postTrip(data, postData);
        return {
            "Message": "성공",
            "Status": 200,
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