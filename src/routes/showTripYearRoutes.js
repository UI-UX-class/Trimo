var express = require("express");
const router = express.Router();
const showTripYearService = require("../service/showTripYearService")

//여행 리스트
router.get("/", async (req,res) => {
    console.log("Routes In1");
    try{
        console.log("Routes Out1");
        //쿼리 파라미터 사용
        //year : ~~, user_id ~~
        const result = await showTripYearService.tripListYear(req.query);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})

module.exports = router;