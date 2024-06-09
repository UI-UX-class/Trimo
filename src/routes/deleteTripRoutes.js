var express = require("express");
const router = express.Router();
const deleteTripService = require("../service/deleteTripService")

router.delete("/", async (req,res) => {
    try{
        console.log('delete trip router');
        const result = await deleteTripService.deleteTrip(req.body);
        res.status(result.Status).json(result);
        console.log(result);
    } catch(err){
        console.log(err);
        res.status(400).json({message: err.message});
    }
})
module.exports = router;