import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';  // 저장소 쓰는 패키지
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
import 'package:http/http.dart' as http;

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
        '/showTrip': (context) => ShowTrip(),// 경로와 해당 페이지를 매핑
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final int? user_id;
  final RouteObserver<PageRoute>? routeObserver;

  MainPage({this.user_id, this.routeObserver});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List trip = [];
  String title = '';  //일단 제목이 있고 여행지가 없는건 아닌거같아서 여기에 여행지 박아두긴 함
  int travel_id = 0;
  String start_date = '';
  String end_date = '';

  // 패키지 객체 생성
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initApp();
  }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.detached) {
  //     _deleteToken();
  //     _loadToken();
  //   }
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 현재 페이지를 RouteObserver에 등록
    final modalRoute = ModalRoute.of(context);
    if (widget.routeObserver != null && modalRoute != null) {
      widget.routeObserver!.subscribe(this as RouteAware, modalRoute as PageRoute);
    }
  }
  @override
  void didPopNext() {
    // 다른 페이지에서 돌아왔을 때 호출되는 함수
    _fetchMain();
  }

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

  Future<void> _initApp() async {
    await _initSharedPreferences();
    await _fetchMain();
  }

  // 패키지 객체를 초기화 해주는 친구 -> 모든 파일에 필요 !
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
  // 토큰 읽어오는 함수
  Future<String?> _readToken() async {
    final myToken = _prefs.getString('jwt_token');
    print('token read success !!');
    print(myToken);
    print('\n');
    return myToken;
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _fetchMain() async{  //메인에서 최근 애 보여주는 친구
    //임시로 토큰 삭제 진행
    //_prefs.remove('jwt_token');
    final token = await _readToken();
    print('main read data');
    print(token);
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
                            //Navigator.pushNamed(context, '/showTrip'); // 최근 여행 페이지 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ShowTrip(tripId: travel_id))
                            );
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
                                '${title}',
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
                                '${start_date} ~ ${end_date}',
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignIn())
                              ); // 로그인 페이지 이동
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyPage())
                          ); // 최근 여행 페이지 이동
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
                        onTap: () async{
                          var token = await _readToken();
                          if(token == null) {
                            print('로그인 하세용 ~ ! ! ');
                            // 여기 나중에 알림창 띄울거임 !!
                          }
                          else {
                            print(token);
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TripListYear()),
                            );
                            if (result != null && result == true) {
                              _fetchMain();
                            }
                          }
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
