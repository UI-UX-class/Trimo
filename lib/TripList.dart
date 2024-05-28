import 'package:flutter/material.dart';
import 'package:trimo/trip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ShowTrip.dart';
import 'WriteTrip.dart';

class TripList extends StatefulWidget {
  final int userId;
  final int year;
  const TripList({super.key, required this.userId, required this.year});
  @override
  State<TripList> createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  Trip trip = Trip(
    tripName: "name",
    tripWhere: "where",
    isAbroad: false,
    tripWhenStart: DateTime(2024, 5, 10),
    tripWhenEnd: DateTime(2024, 5, 13),
    daysDifference: 3,
    tripPlace: {
      1: [""],
      2: [""],
    },
    tripDiary: "",
    tripImage1: '',
    tripImage2: '',
  );

  Map<String,dynamic>? tripData;

  @override
  void initState(){
    super.initState();
    _fetchTripData();
  }

  Future<void> _fetchTripData() async {
    final url = 'http://10.0.2.2:3000/getYearsNote/?user_id=${widget.userId}&year=${widget.year}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        tripData = responseBody['Data'];
        if (tripData != null) {
          trip.tripName = tripData!['title'] ?? '';
          trip.tripWhere = tripData!['country'] ?? '';
          trip.tripDiary = tripData!['contents'] ?? '';

          var year = int.parse(tripData!['start_date']?.substring(0,4) ?? '0');
          var month = int.parse(tripData!['start_date']?.substring(5,7) ?? '0');
          var day = int.parse(tripData!['start_date']?.substring(8,10) ?? '0');
          trip.tripWhenStart = DateTime(year, month, day);

          var year_e = int.parse(tripData!['end_date']?.substring(0,4) ?? '0');
          var month_e = int.parse(tripData!['end_date']?.substring(5,7) ?? '0');
          var day_e = int.parse(tripData!['end_date']?.substring(8,10) ?? '0');
          trip.tripWhenEnd = DateTime(year_e, month_e, day_e);

          trip.tripPlace = {};
          if (tripData!['trip_place'] != null) {
            tripData!['trip_place'].forEach((key, value) {
              trip.tripPlace[int.parse(key)] = List<String>.from(value);
            });
          }
        }
      });
    } else {
      print('Failed to load trip data');
    }
  }


  @override
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> trips = [
      {
        'title': '친구들과 부산여행',
        'location': '부산',
        'date': '05.10~05.13',
        'imagePath': 'assets/busanTest.jpg'
      }
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(' '),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30.0, bottom: 15.0),
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              height: 16,
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.blueAccent, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  '>2024',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
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
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/showTrip');
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: BorderSide(color: Colors.black, width: 0.5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                trip['imagePath']!,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Text(
                              trip['title'] ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${trip['location']} \n${trip['date']}",
                              style: TextStyle(fontSize: 12),
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                PopupMenuItem(
                                  child: Text('수정'),
                                  value: 'edit',
                                ),
                                PopupMenuItem(
                                  child: Text('삭제'),
                                  value: 'delete',
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'edit') {
                                  // 수정 로직 추가
                                } else if (value == 'delete') {
                                  // 삭제 로직 추가
                                }
                              },
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.indigo, width: 1),
                      ),
                      onPressed: () {
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
                        );
                      },
                      child: const Text(
                        "새 일지 생성",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
