const db = require('../config/db')

function signUp(parameter){
    return new Promise((resolve, reject) => {
        var queryData = `insert into user(nickname, id, password, email, pfImg_id)
        value('${parameter.nickname}', '${parameter.id}', '${parameter.password}', '${parameter.email}', 
        ${parameter.pfImg_id})`
        db.query(queryData, (error, db_data) => {
            if(error){
                console.error(queryData + "\n" + "signUp DB Error [user]");
                reject("DB ERR")
            }
            console.log('회원가입 Success ▶\t' + parameter.id + " 성공\n");
            resolve(db_data.insertId)
        })
    })
}
function signUp_token(req) {
    return new Promise((resolve, reject) => {
        var queryData = `update user set jwt_token = '${req.token}' where user_id = ${req.idx}`;
        db.query(queryData, (error, db_data) => {
            if(error){
                console.error(queryData + "\n" + "signUp_token DB Error [user]");
                reject("DB ERR")
            }
            resolve(db_data.insertId);
        })
    })
}

module.exports = {
    signUp,
    signUp_token
}