const showTripDao = require("../dao/showTripDao");

async function trip(req) {
    try {
        if (!req) {
            return {
                "Message": "id 값이 없습니다.",
                "Status": 406
            };
        }
        const trip_data = await showTripDao.showTrip(req);
        const trip_list = [];
        for (const data of trip_data) {
            trip_list.push(data);
        }
        return {
            "Message": "성공",
            "Status": 200,
            "Data": trip_list
        };
    } catch (err) {
        return {
            "Message": "실패",
            "Status": 400,
            "Error_Message": err
        };
    }
}

async function recentTrip(idx) {
    try {
        if (!idx) {
            return {
                "Message": "id 값이 없습니다.",
                "Status": 406
            };
        }
        const trip_data = await showTripDao.recentTrip(idx);
        const trip_list = [];
        for (const data of trip_data) {
            trip_list.push(data);
        }
        return {
            "Message": "성공",
            "Status": 200,
            "Data": trip_list
        };
    } catch (err) {
        return {
            "Message": "실패",
            "Status": 400,
            "Error_Message": err
        };
    }
}

// 새로운 함수 추가
async function getTripById(id) {
    console.log("Service In - GetTripById");
    try {
        const trip_data = await showTripDao.getTripById(id);
        return {
            "Message": "성공",
            "Status": 200,
            "Data": trip_data
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
    trip,
    recentTrip,
    getTripById // 새로운 함수 추가
};