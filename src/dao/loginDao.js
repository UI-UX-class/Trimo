const db = require('../config/db')

function findId(req) {
    console.log("findId dao");
    return new Promise((resolve, reject) => {
        var queryData = `select id from user where id = '${req}'`;
        db.query(queryData, (error, db_data) => {
            if(error){
                console.error(queryData + "\n" + "find ID DB Error [user]");
                reject("DB ERR")
            }
            console.log('find ID Success ▶\t' + req + " 성공\n");
            resolve(db_data)
        })
    })
}

function login(req) {
    console.log("login dao");
    return new Promise((resolve, reject) => {
        var queryData = `select user_id from user 
        where id = '${req.id}' and password = '${req.password}'`;
        db.query(queryData, (error, db_data) => {
            if(error){
                console.error(queryData + "\n" + "login DB Error [user]");
                reject("DB ERR")
            }
            console.log('login Success ▶\t' + req + " 성공\n");
            resolve(db_data)
        })
    })
}

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
    findId,
    login,
    signUp,
    signUp_token
}