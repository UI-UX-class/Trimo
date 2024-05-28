import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:url_launcher/url_launcher.dart';
import './NewPage.dart';
import './MyPage.dart';
import './SignIn.dart';
import './TripListYear.dart';
import './SignUp.dart';
import './ChangeAccountInfo.dart';
import './ShowTrip.dart';
import './WriteTrip.dart';

void main() {
  runApp(TrimoApp());
}

class TrimoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Trimo',
      home: MainPage(),
      routes: {
        '/newPage': (context) => NewPage(),
        '/myPage': (context) => MyPage(),
        '/signInPage': (context) => SignInTest(),
        '/signUpPage': (context) => SignUpTest(),
        '/tripListYear': (context) => TripListYear(),
        '/mainPage': (context) => MainPage(),
        '/changeInfo': (context) => ChangeInfo(),
        '/logInPage': (context) => SignInTest(),
        '/showTrip': (context) => ShowTrip(tripId: 11,),// 경로와 해당 페이지를 매핑
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> bannerList = [
    'assets/travel_banner.png',
    'assets/travel_banner2.png',
    'assets/travel_banner3.png'
  ];

  final List<String> bannerUrls = [
    'https://www.booking.com/',
    'https://www.agoda.com/',
    'https://www.hotels.com/'
  ];

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      resizeToAvoidBottomInset: false,
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
              child:SizedBox(
              width: 330,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/showTrip'); // 최근 여행 페이지 이동
                          },
                          child: Stack(children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(3.0),
                                child: Row(children: [
                                  Image.asset(
                                    'assets/recent_travel.png',
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ])),
                            Positioned(
                              bottom: 26,
                              left: 25,
                              child: Text(
                                '부산',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0, // 텍스트를 이미지의 맨 아래로 정렬
                              right: 10,
                              child: Text(
                                '05.10 ~ 05.13',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
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
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                barrierColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.0),
                                  ),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return WriteTrip();
                                },
                              ); // 새로운 여행 페이지 이동
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset('assets/new_travel.png',
                                      height: 90, fit: BoxFit.contain),
                                  Positioned(
                                    bottom: 3,
                                    left: 0, // 텍스트를 중앙에 정렬
                                    right: 0, // 텍스트를 중앙에 정렬
                                    child: Text(
                                      '새로운 여행',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
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
                              Navigator.pushNamed(context, '/signInPage'); // 로그인 페이지 이동
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
                                        fontSize: 12,
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
                  Container(
                    height: 85,
                    width: 300,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => _launchURL(bannerUrls[index]),
                          child: Image.asset(
                            bannerList[index],
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      itemCount: bannerList.length,
                      pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.indigo, // 활성화된 인디케이터 색상
                          color: Colors.white, // 비활성화된 인디케이터 색상
                        ),
                      ),
                      autoplay: true,
                      autoplayDelay: 8000, // 8초 (8000밀리초)
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/myPage'); // 최근 여행 페이지 이동
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(3.0),
                            child: Stack(children: <Widget>[
                              Image.asset('assets/mypage.png',
                                  height: 96, fit: BoxFit.contain),
                              Positioned(
                                bottom: 5,
                                left: 0, // 텍스트를 중앙에 정렬
                                right: 0, // 텍스트를 중앙에 정렬
                                child: Text(
                                  '마이페이지',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/tripListYear'); // 최근 여행 페이지 이동
                        },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(3.0),
                                child: Stack(children: <Widget>[
                                  Image.asset('assets/all_travel.png',
                                      height: 96, fit: BoxFit.contain),
                                  Positioned(
                                    bottom: 5,
                                    left: 10,
                                    child: Text(
                                      '전체 여행 일지',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ]))),
                      ],
                  ),
                ],
              ),
            ),
            )],
        ),
      ),
    );
  }
}
