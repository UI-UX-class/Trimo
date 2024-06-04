import 'package:flutter/material.dart';
import 'package:trimo/TripList.dart';

class TripListYear extends StatefulWidget {
  const TripListYear({super.key});
  @override
  State<TripListYear> createState() => _TripListYearState();
}

class _TripListYearState extends State<TripListYear> {
  final List<Map<String, String>> trips = [
    {'year': '2024', 'imagePath': 'assets/busanTest.jpg'},
    {'year': '2023', 'imagePath': 'assets/tripListImage1.jpg'},
    {'year': '2022', 'imagePath': 'assets/tripListImage2.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 14, bottom: 15.0),
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
            ),
            const SizedBox(height: 16),
            Container(
              margin: EdgeInsets.only(left: 25, bottom: 20),
              child: Text(
                '여행 일지',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  //회저어~~언
                  return Transform.translate(
                    offset: Offset(index % 2 == 0 ? -40.0 : 40.0, 0),
                    child: Transform.rotate(
                      angle: index % 2 == 0 ? -0.02 : 0.02,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TripList(userId: 1,year: 2024)),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black, // 테두리 색상 설정
                                  width: 1.0, // 테두리 두께 설정
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5), // 그림자 색상
                                    spreadRadius: 1, // 그림자 확산 반경
                                    blurRadius: 6, // 그림자 흐림 정도
                                    offset: Offset(0, 5), // 그림자 위치
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 145,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("${trip['imagePath']}"), // 배경 이미지 설정
                                          fit: BoxFit.cover, // 이미지 크기 조정
                                        ),
                                      ),
                                    ),
                                    ShaderMask(
                                      shaderCallback: (bounds) => LinearGradient(
                                        colors: [Colors.blueAccent, Colors.black],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                      child: Text("${trip['year']}",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              
                            ),
                          ),
                        ),

                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}