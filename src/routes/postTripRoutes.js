var express = require("express");
const router = express.Router();
const postTripService = require("../service/postTripService")

//여행 내용
router.post("/", async (req,res) => {
    console.log("Routes In1");
    try{
//        const user_id = req.session.user_id;
//        const postTrip_req = {...req.body, user_id};
        console.log("Routes Out1");
        const result = await postTripService.postTrip(req.body);
        res.status(201).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})
module.exports = router;