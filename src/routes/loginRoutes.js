var express = require('express');
var router = express.Router();
const loginService = require('../service/loginService');
const authUtil = require('../middlewares/auth');

// router.get('/login', authUtil.checkToken, async(req, res) => {
//     console.log("login get router");
//     try {
//         await loginService.getLogin(req.body, res);
//     } catch (err) {
//         console.log(err);
//         res.status(400).json({ message : err.message });
//     }
// })

router.post('/signup', async(req, res) => {
    console.log('signup post router');
    try {
        const result = await loginService.signUp(req.body);
        res.status(result.Status).json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message : err.message });
    }
})

module.exports = router;