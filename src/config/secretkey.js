module.exports = {
    secretKey : 'happysunday',
    option : {
        algorithm : "HS256", //사용할 알고리즘
        expiresIn : "30d", //토큰 유효 기간 -> 수정해야 함 (짧은거 1개, 긴거 1개로)
        issuer : "issuer" //발행자
    },
    option_short : {
        algorithm : "HS256",
        expiresIn : "1d",
        issuer : "issuer"
    }
}