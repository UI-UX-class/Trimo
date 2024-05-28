import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trimo/ShowTrip.dart';
import 'dart:convert';
import 'WriteTrip.dart';

class TripList extends StatefulWidget {
  final int userId;
  final int year;
  const TripList({super.key, required this.userId, required this.year});

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<dynamic> tripList = [];

  @override
  void initState() {
    super.initState();
    _fetchTripList();
  }

  Future<void> _fetchTripList() async {
    final url = 'http://10.0.2.2:3000/getYearsNote';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': widget.userId,
        'year': widget.year
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        tripList = responseBody['Data'] ?? [];
      });
    } else {
      // Handle error
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(' '),
      ),
      body: tripList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                  itemCount: tripList.length,
                  itemBuilder: (context, index) {
                    final trip = tripList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowTrip(tripId: trip['travel_id'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 18.0),
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
                                trip['image_first'] ?? 'assets/default_image.png',
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Text(
                              trip['title'] ?? 'No Title',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${trip['location'] ?? 'No Location'} \n${trip['date'] ?? 'No Date'}",
                              style: TextStyle(fontSize: 12),
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
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
                        backgroundColor: Colors.white,
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