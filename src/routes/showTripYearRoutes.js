var express = require("express");
const router = express.Router();
const showTripYearService = require("../service/showTripYearService");
const jwt = require('../util/jwt');

//여행 리스트
router.post("/", jwt.authUtil.checkToken, async (req,res) => {
    console.log("show year routes in");
    try{
        const jwt_token = req.headers.jwt_token;
        const token = await jwt.verify(jwt_token);
        console.log("토큰 verify 확인 : ", token.idx);
        const result = await showTripYearService.tripListYear(token.idx);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})

module.exports = router;