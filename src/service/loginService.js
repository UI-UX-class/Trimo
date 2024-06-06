const loginDao = require('../dao/loginDao');
const authUtil = require('../middlewares/auth');
const sign = require('../util/jwt');

async function login(req) {
    console.log("login service : ", req);
    try {
        if(!req.id || !req.password) {
            return {
                "Message" : "요청값이 없습니다.",
                "Status" : 406
            }
        }
        const findId = await loginDao.findId(req.id);
        console.log("findId 확인", findId);
        if(findId == "empty") {
            return {
                "Message" : "아이디가 없습니다.",
                "Status" : 404
            }
        } else {
            const findUser = await loginDao.login(req);
            console.log("findUser return값 확인", findUser);
            if(findUser == "empty") {
                return {
                    "Message" : "비밀번호가 일치하지 않습니다.",
                    "Status" : 404
                }
            } else {
                //console.log("여기 안들어와?");
                const token_req = {
                    "idx" : findUser['user_id'],
                    "id" : req.id
                }
                const jwt_token = await sign.generateToken(token_req);
                console.log("login token : ", jwt_token);
                return {
                    "Message" : "성공",
                    "Data" : jwt_token,  //FN쪽에 가서 local에 저장될 토큰
                    "Status" : 200
                }
            }
        }
    }
    catch(err){
        return {
            "Message" : "실패",
            "Status" : 400,
            "Error" : err
        }
    }
}

async function signUp(req){
    console.log('signup post service');
    try{
        if(!req.id || !req.password){
            return{
                "Message" : "요청값이 없습니다.",
                "Status" : 406
            }
        }
        const user_id = await loginDao.signUp(req);
        console.log('signUp getId : ', user_id);
        const user = {
            "idx" : user_id,
            "id" : req.id
        }
        //긴 토큰 생성 -> DB에 저장되는 애
        const basic_token = await sign.basicToken(user);
        //짧은 토큰 생성 -> 앱에 저장되는 애
        const jwt_token = await sign.generateToken(user);
        const token_req = {
            "token" : basic_token,
            "idx" : user_id
        }
        const signUp_data = await loginDao.signUp_token(token_req);
        return {
            "Message" : "성공",
            "jwt_token" : jwt_token,
            "Data" : signUp_data,  //얘를 줄 필요가 있나?
            "Status" : 200
        }
      }
    catch(err){
        return {
            "Message" : "실패",
            "Status" : 400,
            "Error" : err
        }
    }
}

async function editUser(idx, req) {
    console.log('edit user service', idx, req);
    try {
        if(!req || !idx) {
            return {
                "Message" : "요청값이 없습니다.",
                "Status" : 406
            }
        }
        const editUser_id = await loginDao.editUser(idx, req);
        console.log("editUser_id 확인", editUser_id);
        return {
            "Message" : "성공",
            "Data" : editUser_id,
            "Status" : 200
        }
    }
    catch(err){
        return {
            "Message" : "실패",
            "Status" : 400,
            "Error" : err
        }
    }
}

async function deleteUser(idx) {
    console.log('delete user service', idx);
    try {
        if(!idx) {
            return {
                "Message" : "회원이 없습니다.",
                "Status" : 406
            }
        }
        const deleteUser = await loginDao.deleteUser(idx);
        return {
            "Message" : "성공",
            "Status" : 200
        }
    }
    catch(err){
        return {
            "Message" : "실패",
            "Status" : 400,
            "Error" : err
        }
    }
}


module.exports = {
    login,
    signUp,
    editUser,
    deleteUser
}