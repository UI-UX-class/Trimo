const express = require("express");
const router = express.Router();
const showTripService = require("../service/showTripService");
const jwt = require('../util/jwt');

// 게시물 확인
router.post("/", async (req, res) => {
    console.log("어디세요??");
    try {
        const result = await showTripService.trip(req.body);
        res.status(result.Status).json(result);
        console.log(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// 메인에서 보여줌
router.post("/recent", jwt.authUtil.checkToken, async (req, res) => {
    try {
        const jwt_token = req.headers.jwt_token;
        const token = await jwt.verify(jwt_token);
        console.log("recent 토큰 verify 확인 : ", token.idx);
        const result = await showTripService.recentTrip(token.idx);
        res.status(result.Status).json(result);
        console.log(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// 특정 ID의 여행 데이터 가져오기
router.get("/:id", async (req, res) => {
    console.log("get trip by id router");
    try {
        const result = await showTripService.getTripById(req.params.id);
        res.status(result.Status).json(result);
        console.log(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;