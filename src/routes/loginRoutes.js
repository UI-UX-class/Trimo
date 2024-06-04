var express = require('express');
var router = express.Router();
const loginService = require('../service/loginService');
const authUtil = require('../middlewares/auth');
const jwt = require('../util/jwt');

router.get('/login', async(req, res) => {
    console.log("login router");
    try {
        const loginData = await loginService.login(req.query);
        const token = loginData.jwt_token
        //console.log("확인", token);
        res.cookie('token')
        res.status(loginData.Status).json(loginData);
    } catch (err) {
        console.log(err);
        res.status(400).json({message : err.message});
    }
})

router.post('/signup', async(req, res) => {
    console.log('signup post router');
    try {
        const result = await loginService.signUp(req.body);
        res.status(result.Status).json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({message : err.message});
    }
})

router.put('/edit', authUtil.checkToken, async(req, res) => {
    console.log("edit user router", req.body);
    const jwt_token = req.headers.jwt_token;
    const token = await jwt.verify(jwt_token);
    console.log("토큰 verify 확인 : ", token);
    try {
        const editUser_data = await loginService.editUser(token.idx, req.body);
        res.status(editUser_data.Status).json(editUser_data);
    } catch(err) {
        console.log(err);
        res.status(400).json({message : err.message});
    }
})

router.delete('/delete', authUtil.checkToken, async(req, res) => {
    const jwt_token = req.headers.jwt_token;
    const token = await jwt.verify(jwt_token);
    console.log("토큰 verify 확인 : ", token);
    try {
        const deleteUser_data = await loginService.deleteUser(token.idx);
        res.status(deleteUser_data.Status).json(deleteUser_data);
    } catch(err) {
        console.log(err);
        res.status(400).json({message : err.message});
    }
    //탈퇴 시 토큰 파괴...
})

module.exports = router;