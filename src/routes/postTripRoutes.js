var express = require("express");
const router = express.Router();
const postTripService = require("../service/postTripService")

//여행 내용 post
router.post("/", async (req,res) => {
    try{
        const result = await postTripService.postTrip(req.body);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})
module.exports = router;