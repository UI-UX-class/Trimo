import 'package:flutter/material.dart';

// Test Main
void main() {
  runApp(SignUpTest());
}

// Stateless Widget
class SignUpTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignUp',
      home: SignUp(),
    );
  }
}

// StatefulWidget
class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

// Design
class _SignUp extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRIMO',
          style: TextStyle(
            letterSpacing: 5.0,
            color: Colors.indigo,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TextField 칸
              Padding(
                padding:
                    EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
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
                              EdgeInsets.only(top: 30, left: 20, bottom: 10),
                          child: Text(
                            '닉네임',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 2.0,
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
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Nick Name',
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            '아이디',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 2.0,
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
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'ID',
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            '비밀번호',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 2.0,
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
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            '이메일',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 2.0,
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
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            '프로필 사진',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 20),
                        child: Container(
                          height: 70, //height 안해주니까 사진이 아예 안나옴 ;;
                          //color: Colors.white,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                          //   color: Colors.white,
                          // ),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset('assets/busanTest.jpeg',
                                      width: 100, height: 100, fit: BoxFit.fill),
                                ),
                                onTap: () {},
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset('assets/busanTest.jpeg',
                                      width: 100, height: 100, fit: BoxFit.fill),
                                ),
                                onTap: () {},
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset('assets/busanTest.jpeg',
                                      width: 100, height: 100, fit: BoxFit.fill),
                                ),
                                onTap: () {},
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset('assets/busanTest.jpeg',
                                      width: 100, height: 100, fit: BoxFit.fill),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Login Button
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  //color: Color(0xAA1A4066),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xAA1A4066),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {}, // 로그인 기능과 연결
                  child: Text(
                    "Join",
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
                        padding: EdgeInsets.only(top: 20, left: 20, right: 30),
                        child: Text(
                          "계정이 이미 있으신가요?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "로그인  ->",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}