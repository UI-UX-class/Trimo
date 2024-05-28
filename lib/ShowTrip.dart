import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "./trip.dart";

class ShowTrip extends StatefulWidget {
  final int? tripId;

  ShowTrip({this.tripId});

  @override
  _ShowTripState createState() => _ShowTripState();
}

class _ShowTripState extends State<ShowTrip> {
  Trip trip = Trip(
    tripName: "친구들과 태안 여행",
    tripWhere: "태안",
    isAbroad: false,
    tripWhenStart: DateTime(2024, 5, 10),
    tripWhenEnd: DateTime(2024, 5, 13),
    daysDifference: 3,
    tripPlace: {
      1: ["기흥역 출발", "꽃지수산식당", "꽂지해안공원", "꽂지 해수욕장", "펜션 도착"],
      2: ["펜션 출발", "파도리해식동굴", "파도리해수욕장", "파도리해안사구", "집 도착"],
    },
    tripDiary: "태안 여행의 첫날, 꽂지 해안공원과 꽂지 해수욕장을 방문했다... 어쩌구 저쩌구",
    tripImage1: '/data/user/0/com.example.trimo_write/cache/scaled_1000007976.jpg',
    tripImage2: '/data/user/0/com.example.trimo_write/cache/scaled_1000008055.jpg',
  );

  Map<String, dynamic>? tripData;

  @override
  void initState() {
    super.initState();
    _fetchTripData();
  }

  Future<void> _fetchTripData() async {
    final url = 'http://10.0.2.2:3000/getnote/${widget.tripId}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      print("responseBody");
      print(responseBody);
      setState(() {
        if (responseBody is List) {
          if (responseBody.isNotEmpty) {
            tripData = responseBody[0] as Map<String, dynamic>?;
          }
        } else if (responseBody is Map) {
          if (responseBody['Data'] is List) {
            final dataList = responseBody['Data'] as List;
            if (dataList.isNotEmpty) {
              tripData = dataList[0] as Map<String, dynamic>?;
            }
          } else if (responseBody['Data'] is Map) {
            tripData = responseBody['Data'] as Map<String, dynamic>?;
          }
        }
        if(tripData != null){
          trip.tripName = tripData!['title'] ?? 'Default Trip Name';
          trip.tripWhere = tripData!['country'] ?? 'Default Country';
          trip.tripDiary = tripData!['contents'] ?? 'Default Diary Entry';
          var year = int.parse(tripData?['start_date']?.substring(0,4) ?? '2024');
          var month = int.parse(tripData?['start_date']?.substring(5,7) ?? '05');
          var day = int.parse(tripData?['start_date']?.substring(8,10) ?? '10');
          trip.tripWhenStart = DateTime(year, month, day);
          var year_e = int.parse(tripData?['end_date']?.substring(0,4) ?? '2024');
          var month_e = int.parse(tripData?['end_date']?.substring(5,7) ?? '05');
          var day_e = int.parse(tripData?['end_date']?.substring(8,10) ?? '13');
          trip.tripWhenEnd = DateTime(year_e, month_e, day_e);
          print("hello");
          trip.tripPlace = {};
          tripData!['trip_place'].forEach((key, value){
            trip.tripPlace[int.parse(key)] = List<String>.from(value);
          });
          trip.tripImage1 = tripData!['image_first'] ?? '';
          trip.tripImage2 = tripData!['image_second'] ?? '';
        }
      }
      );
      print(tripData);
    } else {
      print('Failed to load trip data');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("hahahaha");
    print(tripData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(' '),
      ),
      body: tripData == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black, // 테두리 색상
                      width: 1.0, // 테두리 두께
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15.0),
                    ),
                  ),
                  // 여기에 자식 위젯을 추가하세요
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      "${trip.tripName}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    )
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('일지 수정');
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.edit_note,
                                          size: 25.0,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print('일지 삭제');
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.delete_forever_sharp,
                                          size: 25.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Divider(
                            color: Colors.grey, // 선의 색상
                            thickness: 1.0, // 선의 두께
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text("${trip.tripWhere}",
                                    style: TextStyle(
                                        fontSize: 32
                                    ),
                                  ),
                                ),


                                Text("${trip.tripWhenStart.month.toString().padLeft(2, '0')}.${trip.tripWhenStart.day.toString().padLeft(2, '0')}~${trip.tripWhenEnd.month.toString().padLeft(2, '0')}.${trip.tripWhenEnd.day.toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Spacer(),
                              Text("${trip.daysDifference-1}박 ${trip.daysDifference}일",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[400]
                                ),
                              ),
                            ],
                          ),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: trip.tripPlace.length,
                            itemBuilder: (context, index) {
                              int day = index + 1;
                              return Container(
                                margin: EdgeInsets.only(top: 15, right: 30, bottom: 20, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${day}일차", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                    Divider(
                                      color: Colors.grey, // 선의 색상
                                      thickness: 0.5, // 선의 두께
                                    ),
                                    SizedBox(height: 8,),
                                    Text("여행 장소", style: TextStyle(fontSize: 12, color: Colors.grey[500]),),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: trip.tripPlace[day]!.length,
                                      itemBuilder: (context, index2) {
                                        return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5), // 모든 모서리를 10의 반지름으로 둥글게 만듦
                                              border: Border.all(
                                                color: Colors.grey, // 테두리 색상
                                                width: 1, // 테두리 두께
                                              ),
                                            ),
                                            margin: EdgeInsets.only(top: 8),
                                            height: 30,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 10, top: 2),
                                              child: Text("${trip.tripPlace[day]![index2]}"),
                                            )
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("여행 남기기", style: TextStyle(fontSize: 14),),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                color: Color(0xFFEAEBF2),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  child: Text("${trip.tripDiary}", maxLines: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('사진', style: TextStyle(fontSize: 14, color: Color(0xFF565656)),),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 180,
                                        color: Color(0xFFEAEBF2),
                                        child: Container(
                                          height: 180,
                                          color: Color(0xFFEAEBF2),
                                          child: trip.tripImage1.isNotEmpty // 파일이 존재하는지 확인
                                              ? Image.file(File(trip.tripImage1)) // 파일이 존재하면 이미지 출력
                                              : Icon(Icons.image_not_supported), // 파일이 없을 경우 텍스트 출력,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 180,
                                        color: Color(0xFFEAEBF2),
                                        child: trip.tripImage2.isNotEmpty // 파일이 존재하는지 확인
                                            ? Image.file(File(trip.tripImage2)) // 파일이 존재하면 이미지 출력
                                            : Icon(Icons.image_not_supported), // 파일 없으면 아이콘 출력
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              }, // 저장 함수 호출
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.indigo, Colors.black],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '이전 페이지로 돌아가기',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}