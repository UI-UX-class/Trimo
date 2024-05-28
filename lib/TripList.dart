import 'package:flutter/material.dart';
import 'package:trimo/trip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ShowTrip.dart';

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
        trip.tripName = tripData!['title'];
        trip.tripWhere = tripData!['country'];
        trip.tripDiary = tripData!['contents'];
        var year = int.parse(tripData!['start_date'].substring(0,4));
        var month = int.parse(tripData!['start_date'].substring(5,7));
        var day = int.parse(tripData!['start_date'].substring(8,10));
        trip.tripWhenStart = DateTime(year, month, day);
        var year_e = int.parse(tripData!['end_date'].substring(0,4));
        var month_e = int.parse(tripData!['end_date'].substring(5,7));
        var day_e = int.parse(tripData!['end_date'].substring(8,10));
        trip.tripWhenEnd = DateTime(year_e,month_e,day_e);
        print(tripData!['trip_place']["1"][0].runtimeType);
        print("hello");
        trip.tripPlace = {};
        tripData!['trip_place'].forEach((key, value){
          trip.tripPlace[int.parse(key)] = List<String>.from(value);
        });
      });
    } else {
      print('Failed to load trip data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> trips = [
      {'id': 11, 'title': 'Trip to Paris'},
      {'id': 2, 'title': 'Trip to New York'},
      // 더 많은 항목 추가 가능
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
                  )
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
            )
          ],
        ),
      ),
    );
  }
}
