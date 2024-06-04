const jwt = require('jsonwebtoken');
const secretKey = require('../config/secretkey').secretKey
const basic_option = require('../config/secretkey').option
const short_option = require('../config/secretkey').option_short
const token_ex = -3 //토큰 만료
const token_in = -2 //유효하지 않은 토큰

//짧은 애
const generateToken = (payload) => {
    const token = jwt.sign(payload, secretKey, short_option);
    return token;
}

//긴 애
const basicToken = (payload) => {
    const token = jwt.sign(payload, secretKey, basic_option);
    return token;
}

//다시 만드는 애
const refresshToken = (token) => {
    try {
        const decoded = jwt.verify(token, secretKey);
        const payload = {
            idx: decoded.idx,
            id: decoded.id
        };
        const newToken = generateToken(payload);
        return newToken;
    } catch (error) {
        console.error('Error Refreshing Token : ', error);
        return null;
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

module.exports = {generateToken, basicToken, refresshToken, verify};