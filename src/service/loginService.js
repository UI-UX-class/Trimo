const loginDao = require('../dao/loginDao');
const sign = require('../util/jwt');

async function login(req) {
    console.log("login service ");
    try {
        if(!req.id || !req.password) {
            return {
                Message : "요청값이 없습니다.",
                Status : 406
            }
        }
        const findId = await loginDao.findId(req.id);
        if(findId == 'undefined') {
            return {
                Message : "아이디가 없습니다.",
                Status : 404
            }
        } else {
            const findUser = await loginDao.login(req);
            if(findUser == 'undefined') {
                return {
                    Message : "비밀번호가 일치하지 않습니다.",
                    Status : 404
                }
            } else {
                //jwt refresh token 검사
                //기간 만료 -> 재발급
                //살아있다면 generate token 발급
            }
        }
    }
    catch(err){
        return {
            Message : "실패",
            Status : 400,
            Error : err
        }
    }
}

async function signUp(req){
    console.log('signup post service');
    try{
        if(!req.id || !req.password){
            return{
                Message : "요청값이 없습니다.",
                Status : 406
            }
        }
        const user_id = await loginDao.signUp(req);
        console.log('signUp getId : ', user_id);
        const user = {
            "idx" : user_id,
            "id" : req.id
        }
        const jwt_token = await sign.generateToken(user);
        const token_req = {
            "token" : jwt_token,
            "idx" : user_id
        }
        const signUp_data = await loginDao.signUp_token(token_req);
        return {
            Message : "성공",
            jwt_token : jwt_token,
            data : signUp_data,
            Status : 200,
        }
    }
    catch(err){
        return {
            Message : "실패",
            Status : 400,
            Error : err
        }
    }
}

module.exports = {
    login,
    signUp
}