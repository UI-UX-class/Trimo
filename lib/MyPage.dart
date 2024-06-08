import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await _initSharedPreferences();
    await _fetchUser();
  }

  Future<void> _fetchUser() async{  //메인에서 최근 애 보여주는 친구
    //임시로 토큰 삭제 진행
    //_prefs.remove('jwt_token');
    final token = await _readToken();

    print('main read data');
    print(token);

    if(token == null) {
      showAlertDialog(context);
    }
    else {
      Navigator.pushNamed(context, '/changeInfo'); // 최근 여행 페이지 이동
    }

    final url = 'http://10.0.2.2:3000/getnote/recent';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-type': 'application/json',
        'jwt_token' : token ?? ''},
    );
    print(response.headers['jwt_token']);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        trip = responseBody['Data'];
        var newData = trip[0]['country'];
        print(newData);
        print('메인 - 최근 일지 불러오기 데이터 확인\n');
        print(trip);
        title = trip[0]['country'];
        start_date = trip[0]['start_date'].split('T')[0];
        end_date = trip[0]['end_date'].split('T')[0];
        travel_id = trip[0]['travel_id'];
        print(travel_id);
      });
    } else {
      print('Main Recent Fail');
    }
  }

  // 패키지 객체를 초기화 해주는 친구 -> 모든 파일에 필요 !
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
  //토큰 불러오는 함수.
  Future<String?> _readToken() async {
    final myToken = _prefs.getString('jwt_token');
    print('token read success !!');
    print(myToken);
    print('\n');
    return myToken;
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("알림"),
          content: Text("로그인 후 이용해주세요."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _withDraw() async {
    final info = {
      'user_id' : 15  //추후 수정
    };
    print('들어오긴 하나요...');
    var url = "http://10.0.2.2:3000/user/withdraw";
    try {
      var body = json.encode(info);
      print(body);
      print('\n');
      var response = await http.delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body : body,
      );
      print('????');
      if(response.statusCode == 200) {
        print('성공했다면 나올 말');
        Navigator.pushNamed(context, '/mainPage');
      }else{
        print('데이터 저장 실패: ${response.statusCode}');
        print('응답 내용: ${response.body}');
      }
    }catch(e){
      print("오류 발생: $e");
    }
  }

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
                            onTap: () async{
                              var token = await _readToken();
                              if(token == null) {
                                showAlertDialog(context);
                              }
                              else {
                                Navigator.pushNamed(context, '/changeInfo'); // 최근 여행 페이지 이동
                              }
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: GestureDetector(
                          onTap: () async{
                            var token = await _readToken();
                            if(token == null) {
                              showAlertDialog(context);
                            }
                            else {
                              _withDraw();
                            }
                          },
                          child: Text(
                            "회원탈퇴",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
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
