var express = require("express");
const router = express.Router();
const updateTripService = require("../service/updateTripService")

//여행 내용 post
router.put("/:id", async (req,res) => {
    console.log("라우터 들어옴");
    try{
        const result = await updateTripService.updateTrip(req.body, req.params.id);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})

module.exports = router;