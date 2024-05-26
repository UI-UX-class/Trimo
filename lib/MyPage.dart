import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './NewPage.dart';

void main() {
  runApp(maybeMyPage());
}

class maybeMyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: {
        '/newPage': (context) => NewPage(), // 경로와 해당 페이지를 매핑
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 90.0, bottom: 40.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/newPage'); // 최근 여행 페이지 이동
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
                              Navigator.pushNamed(context, '/newPage'); // 최근 여행 페이지 이동
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
                              Navigator.pushNamed(context, '/newPage'); // 최근 여행 페이지 이동
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
                  Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3.0),
                        child: Stack(
                          children: [
                            Image.asset('assets/license.png',
                                width: 305,
                                height: 60, fit: BoxFit.fill),
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
                      )

                  )],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
