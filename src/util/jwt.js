const jwt = require('jsonwebtoken');
const secretKey = require('../config/secretkey').secretKey
const option = require('../config/secretkey').option
const token_ex = -3 //토큰 만료
const token_in = -2 //유효하지 않은 토큰

const generateToken = (payload) => {
    const token = jwt.sign(payload, secretKey, option);
    return token;
}

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
        console.error('Error Refreshing Token: ', error);
        return null;
    }
}

module.exports = {generateToken, refresshToken};