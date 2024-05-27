var express = require("express");
const router = express.Router();
const showTripService = require("../service/showTripService")

//게시물 확인
router.post("/", async (req,res) => {
    console.log("Routes In1");
    try{
        console.log("Routes Out1");
        const result = await showTripService.trip(req.body);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})

//게시물 만든 직후 이동
router.post("/recent",async(req,res) => {
    console.log("Routes In1");
    try{
        console.log("Routes Out1");
        const result = await showTripService.recentTrip(req.body);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})

//여행 리스트
router.get("/listYear", async (req,res) => {
    console.log("Routes In1");
    try{
        console.log("Routes Out1");
        //쿼리 파라미터 사용
        //year : ~~, user_id ~~
        const result = await showTripService.tripListYear(req.query);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})

module.exports = router;