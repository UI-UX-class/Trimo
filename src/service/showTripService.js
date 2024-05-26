const showTripDao = require("../dao/showTripDao")

async function trip(req){
    console.log("Service In1")
    try{
        if(!req){
            return {
                "Message" : "id 값이 없습니다.",
                "Status" : 406
            }
        }
        console.log("Service Out1");
        const trip_data = await showTripDao.showTrip(req);
        console.log("Service In2")
        const trip_list = [];
        for(const data of trip_data){
            trip_list.push(data);
        }
        console.log("Service Out2");
        return {
            "Message" : "성공",
            "Status" : 200,
            "Data" : trip_list
        }
    }catch(err){
        return {
            "Message" : "실패",
            "Status" : 400,
            "Error_Message" : err
        }
    }
}

async function tripListYear(req){
    console.log("Service In1")
    try{
        if(!req){
            return {
                "Message" : "id 값이 없습니다.",
                "Status" : 406
            }
        }
        console.log("Service Out1");
        const trip_data = await showTripDao.showTripListYear(req);
        console.log("Service In2")
        const trip_list = [];
        for(const data of trip_data){
            trip_list.push(data);
        }
        console.log("Service Out2");
        return {
            "Message" : "성공",
            "Status" : 200,
            "Data" : trip_list
        }
    }catch(err){
        return {
            "Message" : "실패",
            "Status" : 400,
            "Error_Message" : err
        }
    }
}



module.exports = {
    trip,
    tripListYear,
}