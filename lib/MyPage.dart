import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './main.dart';
import './NewPage.dart';
import './ChangeAccountInfo.dart';
import './SignIn.dart';

void main() {
  runApp(MyPage());
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MyPage();
  }
}

class _MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<_MyPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(''),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 40.0),
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
            Center(
              child: SizedBox(
              width: 330,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                          },
                          child: Stack(children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(3.0),
                                child: Row(children: [
                                  Image.asset(
                                    'assets/profile_background.png',
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ])),
                            Positioned(
                                top: 10,
                                left: 0,
                                right: 0,
                                child: Image.asset(
                                'assets/no_profile.png',
                                height: 130,
                                fit: BoxFit.contain)),
                            Positioned(
                              bottom: 15,
                              left: 0,// 텍스트를 이미지의 맨 아래로 정렬
                              right: 0,
                              child: Text(
                                '로그인이 필요합니다.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ])),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/logInPage'); // 로그인 페이지 이동
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset('assets/login.png',
                                      height: 90, fit: BoxFit.contain),
                                  Positioned(
                                    bottom: 3,
                                    left: 0, // 텍스트를 중앙에 정렬
                                    right: 0, // 텍스트를 중앙에 정렬
                                    child: Text(
                                      '로그인',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/changeInfo'); // 최근 여행 페이지 이동
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset('assets/mypage.png',
                                      height: 90, fit: BoxFit.contain),
                                  Positioned(
                                    bottom: 3,
                                    left: 0, // 텍스트를 중앙에 정렬
                                    right: 0, // 텍스트를 중앙에 정렬
                                    child: Text(
                                      '회원정보 수정',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("라이센스",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            content: Text("이 앱의 라이센스 정보입니다."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // 다이얼로그 닫기
                                },
                                child: Text("확인"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/license.png',
                            width: 305,
                            height: 60,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            top: 15,
                            left: 0, // 텍스트를 중앙에 정렬
                            right: 0, // 텍스트를 중앙에 정렬
                            child: Text(
                              '라이센스',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            )],
        ),
      ),
    );
  }
}
