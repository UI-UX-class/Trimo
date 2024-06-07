import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'FixTrip.dart';
import 'ShowTrip.dart';
import 'WriteTrip.dart';

class TripList extends StatefulWidget {
  final int userId;
  final int year;

  TripList({required this.userId, required this.year});

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List trips = [];

  @override
  void initState() {
    super.initState();
    _fetchTripList();
  }

  // Future<void> _fetchTripListWithDelay() async {
  //   await Future.delayed(Duration(milliseconds: 500));  // 0.3초 대기
  //   _fetchTripList();
  // }

  Future<void> _fetchTripList() async {
    final url = 'http://10.0.2.2:3000/getYearsNote';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': widget.userId,
        'year': widget.year,
      }),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        trips = responseBody['Data'];
      });
    } else {
      print('Failed to load trip list');
    }
  }

  Future<void> _deleteTripData(travel_id) async {
    final url = 'http://10.0.2.2:3000/delnote';
    final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'travel_id' : travel_id
        })
    );
    return Future(() => null);
  }

  String formatDate(String dateStr) {
    // Parse the date string
    DateTime date = DateTime.parse(dateStr);
    // Format the date to only show month and day
    return DateFormat('MM/dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.year.toString(),
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
                    String imagePath = trips[index]['image_first'];
                    File imageFile = File(imagePath);
                    final trip = trips[index];
                    return GestureDetector(
                      onTap: () async{
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowTrip(tripId: trip['travel_id']),
                          ),
                        ).then((value){
                          setState(() {
                          });
                        });
                        if(result != null && result ==true){
                          _fetchTripList();
                        }
                      },
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: BorderSide(color: Colors.black, width: 0.5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: imagePath != null && imageFile.existsSync()
                                ? Image.file(imageFile)
                                : Icon(Icons.image),
                            title: Text(
                              trip['title'] ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${trips[index]['country']} \n${formatDate(trips[index]['start_date'])} ~ ${formatDate(trips[index]['end_date'])}',
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
                              onSelected: (value) async{
                                if (value == 'edit') {
                                  // 수정 로직 추가
                                  final re = await showModalBottomSheet<bool>(
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
                                      return FixTrip(tripId: trip['travel_id']);
                                    },
                                  );
                                  if( re == true ){
                                   Navigator.pop(context);
                                  }
                                } else if (value == 'delete') {
                                  _deleteTripData(trip['travel_id']);
                                  Navigator.pop(context);
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
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async{
                        final re = await showModalBottomSheet<bool>(
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
                        if(re == true){
                          setState(() {
                            _fetchTripList();
                          });
                        }
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