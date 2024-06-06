const { query } = require('express');
const db = require('../config/db')

function findId(req) {
    console.log("findId dao", req);
    return new Promise((resolve, reject) => {
        var queryData = `select user_id from user where id = '${req}'`;
        db.query(queryData, (error, db_data) => {
            if(error){
                console.error(queryData + "\n" + "find ID DB Error [user]");
                reject("DB ERR")
            }
            else if(!db_data.length) {
                console.log('Not DB [user] data : ' + req + " 실패\n");
                db_data = "empty";
                resolve(db_data)
            }
            else {
                console.log('find ID Success ▶\t' + req + " 성공\n");
                resolve(db_data)
            }
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
            else if(!db_data.length) {
                console.log('Not DB [user] login data : ' + req.id + " 실패\n");
                db_data = "empty";
                resolve(db_data)
            }
            else {
                console.log('login Success ▶\t' + req.id+ " 성공\n");
                resolve(db_data)
            }
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
            } else {
                console.log('회원가입 Success ▶\t' + parameter.id + "\t성공\n");
                resolve(db_data.insertId)
            }
        })
    })
}
function signIn_token(token, idx) {
    return new Promise((resolve, reject) => {
        var queryData = `update user set jwt_token = '${token}' where user_id = ${idx}`;
        db.query(queryData, (error, db_data) => {
            if(error){
                console.error(queryData + "\n" + "signIn_token DB Error [user]");
                reject("DB ERR")
            } else {
                resolve(db_data.insertId);
            }
        })
    })
}

function getUser(idx) {
    return new Promise((resolve, reject) => {
        var queryData = `select nickname, id, password, email, pfImg_id from user where user_id = ${idx}`;
        db.query(queryData, (error, db_data) => {
            if(error) {
                console.error(queryData + "\n" + "getUser DB Error [user]");
                reject("DB ERR")
            } else {
                resolve(db_data);
            }
        })
    })
}

function editUser(idx, req) {
    return new Promise((resolve, reject) => {
        var queryData = `update user set nickname = '${req.nickname}', password = '${req.password}', 
        email = '${req.email}' where user_id = ${idx}`;
        db.query(queryData, (error, db_data) => {
            if(error) {
                console.error(queryData + "\n" + error + "editUser DB Error [user]");
                reject("DB ERR")
            }
            else {
                console.log('회원수정 Success ▶\t' + idx + "\t성공\n");
                resolve(idx);
            }
        })
    })
}

function deleteUser(idx) {
    return new Promise((resolve, reject) => {
        var queryData = `delete from user where user_id = ${idx}`;
        db.query(queryData, (error, db_data) => {
            if(error) {
                console.error(queryData + "\n" + "deleteUser DB Error [user]");
                reject("DB ERR")
            } else {
                console.log('회원탈퇴 Success ▶\t' + idx.user_id + "\t성공\n");
                resolve(db_data);
            }
        })
    })
}

module.exports = {
    findId,
    login,
    signUp,
    signIn_token,
    getUser,
    editUser,
    deleteUser
}