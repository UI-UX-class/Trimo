const showTripYearDao = require("../dao/showTripYearDao")

async function tripListYear(idx){
    try{
        console.log('show year service in')
        if(!idx){
            return {
                "Message" : "id 값이 없습니다.",
                "Status" : 406
            }
        }
        const trip_data = await showTripYearDao.showTripListYear(idx);
        return {
            "Message" : "성공",
            "Status" : 200,
            "Data" : trip_data
        }
    } catch(err) {
        return {
            "Message" : "실패",
            "Status" : 400,
            "Error_Message" : err
        }
    }
}

module.exports = {
    tripListYear,
}