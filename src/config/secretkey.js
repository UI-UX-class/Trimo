module.exports = {
    secretKey : 'happysunday',
    option : {
        algorithm : "HS256", //사용할 알고리즘
        expiresIn : "1d", //토큰 유효 기간
        issuer : "issuer" //발행자
    },
}