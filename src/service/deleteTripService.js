const deleteTripDao = require("../dao/deleteTripDao");

async function deleteTrip(data) {
    try {
        console.log("delete trip service", data);
        const result = await deleteTripDao.deleteTrip(data.travel_id);
        return {
            "Message": "성공",
            "Status": 200
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
    deleteTrip
};