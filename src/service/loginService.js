const loginDao = require('../dao/loginDao');
const jwt = require('../util/jwt');

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
            if(findUser == "empty") {
                return {
                    "Message" : "비밀번호가 일치하지 않습니다.",
                    "Status" : 404
                }
            } else {
                console.log(findUser[0]['user_id']);
                const token_req = {
                    "idx" : findUser[0]['user_id'],
                    "id" : req.id
                }
                const jwt_token = await jwt.accessToken(token_req);
                console.log("login new token 발급 : ", jwt_token);
                
                //db에 새로운 토큰 갱신...
                await loginDao.signIn_token(jwt_token, token_req.idx);
                return {
                    "Message" : "성공",
                    "Data" : token_req.idx,
                    "jwt_token" : jwt_token,  //FN쪽에 가서 local에 저장될 토큰
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

async function getUser(idx) {
    console.log('edit get user service', idx);
    try {
        if(!idx) {
            return {
                "Message" : "요청값이 없습니다.",
                "Status" : 406
            }
        }
        const getUser_data = await loginDao.getUser(idx);
        console.log('getUser 확인', getUser_data);
        return {
            "Message" : "성공",
            "Data" : getUser_data,
            "Status" : 200
        }
    }
    catch (err) {
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
            "Status" : 200,
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

async function getProfile(idx) {
    console.log('get profile service', idx);
    try {
        if(!idx) {
            return {
                "Message" : "id가 없습니다.",
                "Status" : 406
            }
        }
        const getProfile_data = await loginDao.getProfile(idx);
        return {
            "Message" : "성공",
            "Data" : getProfile_data,
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
    getUser,
    editUser,
    deleteUser,
    getProfile
}