var express = require("express");
const router = express.Router();
const postTripService = require("../service/postTripService");
const jwt = require('../util/jwt');

router.post("/", jwt.authUtil.checkToken, async (req,res) => {
    try{
        const jwt_token = req.headers.jwt_token;
        const token = await jwt.verify(jwt_token);
        const result = await postTripService.postTrip(token.idx, req.body);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})
module.exports = router;