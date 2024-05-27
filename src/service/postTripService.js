const postTripDao = require("../dao/postTripDao");

async function postTrip(data) {
    console.log("Service In");
    try {
        const result = await postTripDao.postTrip(data);
        return {
            "Message": "성공",
            "Status": 201,
            "Data": result
        };
    } catch (err) {
        return {
            "Message": "실패",
            "Status": 400,
            "Error_Message": err.message
        };
    }
}

module.exports = {
    postTrip
};