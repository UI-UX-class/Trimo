import 'package:flutter/material.dart';
import 'package:trimo/SignIn.dart';
import './MyPage.dart';

// Test Main
void main() {
  runApp(ChangeInfo());
}

// Stateless Widget
class ChangeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignUp',
      home: _ChangeInfo(),
      routes: {
        '/myPage': (context) => MyPage(),// 메인 페이지 경로 추가
      },
    );
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

  // TextEditingController 선언
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/myPage'); // 마이페이지로 이동
          },
        ),
        title: const Text(''),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      LinearGradient(
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
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[850],
                  ),),),
              // TextField 칸
              Padding(
                padding:
                EdgeInsets.only(left: 60, right: 60, bottom: 20),
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
                        padding: EdgeInsets.only(
                            left: 15, right: 15, bottom: 20),
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
                              controller: _nicknameController,
                              decoration: InputDecoration(
                                hintText: 'Nick Name',
                                contentPadding: EdgeInsets.all(8),
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
                        padding: EdgeInsets.only(
                            left: 15, right: 15, bottom: 20),
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
                              controller: _idController,
                              decoration: InputDecoration(
                                hintText: 'ID',
                                contentPadding: EdgeInsets.all(8),
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
              // Login Button
              Container(
                width: 290,
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
                    String nick_name = _nicknameController.text;
                    String id = _idController.text;
                    String password = _passwordController.text;
                    String email = _emailController.text;
                    Navigator.pushNamed(context, '/myPage');
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                        EdgeInsets.only(top: 20, left: 20, right: 65),
                        child: Text("",),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 65, bottom: 10),
                      child: TextButton(
                        onPressed: () {
                        },
                        child: Text(""),
                        ),
                      ),
                    ]
                ),
              )
            ],
          ),
        ),
      ),
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
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}