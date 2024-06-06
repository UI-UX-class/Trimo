const updateTripDao = require("../dao/updateTripDao");

async function updateTrip(data, id) {
    console.log("서비스 들어옴");
    //console.log(data);
    //console.log(id);
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

        const updateData = {
            travel_id : id,
            trip_place : detailsJSON,
            time : `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
        }
        const result = await updateTripDao.updateTrip(data, updateData);
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
    updateTrip
};