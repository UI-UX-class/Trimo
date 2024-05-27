const showTripDao = require("../dao/showTripDao");

async function trip(req) {
    console.log("Service In1");
    try {
        if (!req) {
            return {
                "Message": "id 값이 없습니다.",
                "Status": 406
            };
        }
        console.log("Service Out1");
        const trip_data = await showTripDao.showTrip(req);
        console.log("Service In2");
        const trip_list = [];
        for (const data of trip_data) {
            trip_list.push(data);
        }
        console.log("Service Out2");
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

async function recentTrip(req) {
    console.log("Service In1");
    try {
        if (!req) {
            return {
                "Message": "id 값이 없습니다.",
                "Status": 406
            };
        }
        console.log("Service Out1");
        const trip_data = await showTripDao.recentTrip(req);
        console.log("Service In2");
        const trip_list = [];
        for (const data of trip_data) {
            trip_list.push(data);
        }
        console.log("Service Out2");
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

async function tripListYear(req) {
    console.log("Service In1");
    try {
        if (!req) {
            return {
                "Message": "id 값이 없습니다.",
                "Status": 406
            };
        }
        console.log("Service Out1");
        const trip_data = await showTripDao.showTripListYear(req);
        console.log("Service In2");
        const trip_list = [];
        for (const data of trip_data) {
            trip_list.push(data);
        }
        console.log("Service Out2");
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
    tripListYear,
    getTripById // 새로운 함수 추가
};