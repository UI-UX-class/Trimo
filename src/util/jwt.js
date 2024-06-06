const jwt = require('jsonwebtoken');
const secretKey = require('../config/secretkey').secretKey
const basic_option = require('../config/secretkey').option
const short_option = require('../config/secretkey').option_short
const token_ex = -3 //토큰 만료
const token_in = -2 //유효하지 않은 토큰

//짧은 애
const accessToken = (payload) => {
    const token = jwt.sign(payload, secretKey, short_option);
    return token;
}

//긴 애 -> 필요 X
// const basicToken = (payload) => {
//     const token = jwt.sign(payload, secretKey, basic_option);
//     return token;
// }

//다시 만드는 애 -> 수정 필요
// const refresshToken = (token) => {
//     try {
//         const decoded = jwt.verify(token, secretKey);
//         const payload = {
//             idx: decoded.idx,
//             id: decoded.id
//         };
//         const newToken = generateToken(payload);
//         return newToken;
//     } catch (error) {
//         console.error('Error Refreshing Token : ', error);
//         return null;
//     }
// }

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