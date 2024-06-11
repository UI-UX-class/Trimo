const jwt = require('jsonwebtoken');
const secretKey = require('../config/secretkey').secretKey
const basic_option = require('../config/secretkey').option

// 토큰 발급
const accessToken = (payload) => {
    const token = jwt.sign(payload, secretKey, basic_option);
    return token;
}

// 토큰 여부, 유효성 확인
const authUtil = {
    checkToken : async(req, res, next) => {
        var token = req.headers.jwt_token;
        if(token == '') {
            console.log('undefined !!!')
            res.status(400).send({
                "Message" : "토큰이 없습니다.",
                "Status" : 400  //없어도 되나?
            })
        }
        else {
            var access = validateToken(token);
            if(!access) {
                console.log('not access');
                res.status(401).send ({
                    "Message" : "유효하지 않은 토큰입니다. 다시 로그인 해 주세요.",
                    "Status" : 406
                })
            } else {
                console.log('checkToken Success !');
                next();
            }
        }
    }
}

// 토큰 유효화 확인
function validateToken(token) {
    try {
        var token_data = jwt.verify(token, secretKey)
        return token_data;
    } catch (error) {
        return false;
    }
}

const verify = (token) => {
    let decoded;
    try {
        decoded = jwt.verify(token, secretKey)
        return decoded
    }
    catch (err) {
        console.error(err);
    }
}

module.exports = {
    accessToken, 
    authUtil,
    verify
};