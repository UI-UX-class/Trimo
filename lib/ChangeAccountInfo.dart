import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trimo/MyPage.dart';
import 'package:trimo/SignIn.dart';

// Stateless Widget
class ChangeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ChangeInfo();
  }
}

// StatefulWidget
class _ChangeInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangeInfoState();
  }
}

// Design
class ChangeInfoState extends State<_ChangeInfo> {
  late ScrollController _scrollController;
  int _selectedAvatarIndex = -1; // 선택된 이미지의 인덱스를 저장
  String _selectedAvatarPath = '';
  late SharedPreferences _prefs;

  // TextEditingController 선언
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initApp();
  }

  Future<void> _initApp() async {
    await _initSharedPreferences();
    await _fetchUserData();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
  Future<String?> _readToken() async {
    final myToken = _prefs.getString('jwt_token');
    print('token read success !!');
    print(myToken);
    print('\n');
    return myToken;
  }

  // 페이지 들어오면 초기값 get
  Future<void> _fetchUserData() async {
    final token = await _readToken();
    print('get profile read token');
    print(token);
    final uri = 'http://10.0.2.2:3000/user/edit';
    var response = await http.post(
      Uri.parse(uri),
      headers: {"Content-Type": "application/json",
      'jwt_token' : token ?? ''},
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody["Data"][0]);
      setState(() {
        _nicknameController.text = responseBody["Data"][0]["nickname"] ?? '안녕';
        _idController.text = responseBody["Data"][0]["id"] ?? '';
        _passwordController.text = responseBody["Data"][0]["password"] ?? '';
        _emailController.text = responseBody["Data"][0]["email"] ?? '';
        _selectedAvatarIndex = responseBody["Data"][0]["pfImg_id"] ?? 0;
      });
    } else {
      print('Failed to load user data');
    }
  }

  // 버튼 누를 때 회원 정보 put
  Future<void> _updateUser() async {
    String nickname = _nicknameController.text;
    String id = _idController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    int pfImg_id = _selectedAvatarIndex;

    var uri = "http://10.0.2.2:3000/user/edit";
    try {
      final token = await _readToken();
      print('get profile read token');
      print(token);
      var body = json.encode({
        'nickname': nickname,
        'id': id,
        'password': password,
        'email': email,
        'pfImg_id': pfImg_id,
        'user_id' : 14
      });
      print(body);
      var response = await http.put(
        Uri.parse(uri),
        headers: {"Content-Type": "application/json",
        'jwt_token' : token ?? ''},
        body: body,
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyPage(),
          ),
        );
      } else {
        print('데이터 저장 실패: ${response.statusCode}');
        print('응답 내용: ${response.body}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(''),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.blueAccent, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'TRIMO',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 290,
                  child:Text('회원정보수정',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[850],
                    ),),),
                SizedBox(
                  height: 3,
                ),
                // TextField 칸
                SizedBox(
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xAA1A4066),
                    ),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                            EdgeInsets.only(top: 20, left: 20, bottom: 10),
                            child: Text(
                              '닉네임',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                          child: Container(
                            //color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: 30,
                              width: 270,
                              child: TextField(
                                textAlignVertical: TextAlignVertical(y: 0.0),
                                controller: _nicknameController,
                                decoration: InputDecoration(
                                  hintText: 'Nick Name',
                                  contentPadding: EdgeInsets.all(8),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              '아이디',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                          child: Container(
                            //color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: 30,
                              width: 270,
                              child:TextField(
                                enabled: false,
                                controller: _idController,
                                decoration: InputDecoration(
                                  hintText: 'ID',
                                  contentPadding: EdgeInsets.all(8),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              '비밀번호',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, bottom: 20),
                          child: Container(
                            //color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: 30,
                              width: 270,
                              child: TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  contentPadding: EdgeInsets.all(8),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              '이메일',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, bottom: 20),
                          child: Container(
                            //color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              height: 30,
                              width: 270,
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.all(8),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              '프로필 사진',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: 15, right: 15, bottom: 20),
                          child: Container(
                            height: 90,
                            child: Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              child: ListView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  _buildAvatarImage('assets/avatar1.png', 0),
                                  _buildAvatarImage('assets/avatar2.png', 1),
                                  _buildAvatarImage('assets/avatar3.png', 2),
                                  _buildAvatarImage('assets/avatar4.png', 3),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Login Button
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xAA1A4066),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      _updateUser();
                    }, // 로그인 기능과 연결
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // Text - 회원가입으로 이동
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildAvatarImage(String imagePath, int index) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(1),
        child: Container(
          decoration: BoxDecoration(
            border: _selectedAvatarIndex == index
                ? Border.all(color: Colors.blue, width: 3)
                : null,
          ),
          child: Image.asset(
            imagePath,
            height: 100,
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _selectedAvatarPath = imagePath; // 고른 이미지 주소
          _selectedAvatarIndex = index;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}