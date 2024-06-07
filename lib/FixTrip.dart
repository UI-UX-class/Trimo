import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:trimo/ShowTrip.dart';
import './trip.dart';

enum Location {
  domestic,
  abroad,
}

class FixTrip extends StatefulWidget {
  final int? tripId;

  FixTrip({this.tripId});

  @override
  State<FixTrip> createState() => _FixTripState();
}

class _FixTripState extends State<FixTrip> {
  Trip trip = Trip(
    tripName: "친구들과 태안 여행",
    tripWhere: "태안",
    isAbroad: false,
    tripWhenStart: DateTime(2024, 5, 10),
    tripWhenEnd: DateTime(2024, 5, 13),
    daysDifference: 3,
    tripPlace: {
      1: ["", "",],
    },
    tripDiary: "태안 여행의 첫날, 꽂지 해안공원과 꽂지 해수욕장을 방문했다... 어쩌구 저쩌구",
    tripImage1: '/data/user/0/com.example.trimo_write/cache/scaled_1000007976.jpg',
    tripImage2: '/data/user/0/com.example.trimo_write/cache/scaled_1000008055.jpg',
  );

  Map<String, dynamic>? tripData;

  @override
  late TextEditingController _tripNameController;
  late TextEditingController _tripWhereController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _tripDiaryController;
  int _daysDifference = 0;

  int _setIndex = 1; // 1일차, 2일차 구분하는 index
  Location _selectedLocation = Location.domestic; // 변수 초기화
  Map<int, List<String>> _tripPlace = {}; // 1일차 장소, 2일차 장소 자료 구조
  String anyString = '';

  final picker = ImagePicker();
  File? _image1;
  File? _image2; // 가져온 사진들을 보여주기 위한 변수
  late String image1Path;
  late String image2Path;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _fetchTripData();
  }

  void _initializeControllers() {
    _tripNameController = TextEditingController();
    _tripWhereController = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _tripDiaryController = TextEditingController();
  }

  // 일차 추가 함수
  void addData(int index) {
    setState(() {
      _tripPlace[index] = ["", ""];
    });
  }

  // 날짜 차이 업데이트 함수
  void _updateDaysDifference() {
    final startDate = DateTime.tryParse(_startDateController.text);
    final endDate = DateTime.tryParse(_endDateController.text);
    if (startDate != null && endDate != null) {
      final difference = endDate.difference(startDate).inDays;
      setState(() {
        _daysDifference = difference;
      });
    } else {
      setState(() {
        _daysDifference = 0;
      });
    }
  }

  // 저장된 값 불러오기
  Future<void> _fetchTripData() async {
    final url = 'http://10.0.2.2:3000/getnote/${widget.tripId}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

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

        if (tripData != null) {
          trip.tripName = tripData!['title'] ?? 'Default Trip Name';
          trip.tripWhere = tripData!['country'] ?? 'Default Country';
          trip.tripDiary = tripData!['contents'] ?? 'Default Diary Entry';
          var startDate = tripData!['start_date'] as String?;
          var endDate = tripData!['end_date'] as String?;
          trip.daysDifference = tripData!['days'] ?? 0;

          if (startDate != null && endDate != null) {
            trip.tripWhenStart = DateTime.parse(startDate);
            trip.tripWhenEnd = DateTime.parse(endDate);

            _startDateController.text = "${trip.tripWhenStart.year}-${trip.tripWhenStart.month.toString().padLeft(2, '0')}-${trip.tripWhenStart.day.toString().padLeft(2, '0')}";
            _endDateController.text = "${trip.tripWhenEnd.year}-${trip.tripWhenEnd.month.toString().padLeft(2, '0')}-${trip.tripWhenEnd.day.toString().padLeft(2, '0')}";
          }

          trip.tripPlace = {};
          tripData!['trip_place'].forEach((key, value) {
            trip.tripPlace[int.parse(key)] = List<String>.from(value);
          });

          print(tripData);

          trip.tripImage1 = tripData!['image_first'] ?? '';
          trip.tripImage2 = tripData!['image_second'] ?? '';

          image1Path = trip.tripImage1;
          image2Path = trip.tripImage2;

          _image1 = File(trip.tripImage1);
          _image2 = File(trip.tripImage2);

          _tripNameController.text = trip.tripName;
          _tripWhereController.text = trip.tripWhere;
          _tripDiaryController.text = trip.tripDiary;

          _daysDifference = trip.daysDifference;

          // 업데이트된 tripPlace 맵을 _tripPlace에 반영
          _tripPlace = Map.from(trip.tripPlace);
        }
      });
    } else {
      print('Failed to load trip data');
    }
  }

  // 여행 정보 저장 함수
  Future<void> _saveTrip() async {
    final newTrip = Trip(
      tripName: _tripNameController.text,
      tripWhere: _tripWhereController.text,
      isAbroad: _selectedLocation == Location.abroad,
      tripWhenStart: DateTime.parse(_startDateController.text),
      tripWhenEnd: DateTime.parse(_endDateController.text),
      daysDifference: _daysDifference,
      tripPlace: _tripPlace,
      tripDiary: _tripDiaryController.text,
      tripImage1: image1Path,
      tripImage2: image2Path,
    );

    var uri = "http://10.0.2.2:3000/updatenote/${widget.tripId}";
    try {
      var body = json.encode(newTrip.toJson());
      print(body);
      var response = await http.put(
        Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        Navigator.pop(
          context,
          true
        );
      } else {
        print('데이터 저장 실패: ${response.statusCode}');
        print('응답 내용: ${response.body}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.77,
      width: MediaQuery.of(context).size.width * 0.80,
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Divider(
                color: Colors.indigo,
                thickness: 3,
                height: 10,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 8,
                height: 1,
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: TextField(
                  controller: _tripNameController,
                  decoration: InputDecoration(
                    labelText: "여행일지 이름",
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _tripWhereController,
                        decoration: InputDecoration(
                          labelText: "여행지",
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 40,
                        child: ToggleButtons(
                          isSelected: [_selectedLocation == Location.domestic, _selectedLocation == Location.abroad],
                          onPressed: (index) {
                            setState(() {
                              _selectedLocation = index == 0 ? Location.domestic : Location.abroad;
                            });
                          },
                          children: [
                            Text('국내'),
                            Text('해외'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    // 시작 날짜 TextField 수정
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: TextField(
                          controller: _startDateController,
                          decoration: InputDecoration(
                            labelText: "시작 날짜",
                          ),
                          keyboardType: TextInputType.datetime,
                          maxLines: 1,
                          onChanged: (value) {
                            if (value.length >= 10) {
                              setState(() {
                                _startDateController.text = value.substring(0, 10);
                                _updateDaysDifference();
                              });
                            }
                          },
                        ),
                      ),
                    ),

// 종료 날짜 TextField 수정
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: _endDateController,
                          decoration: InputDecoration(
                            labelText: "도착 날짜",
                          ),
                          keyboardType: TextInputType.datetime,
                          maxLines: 1,
                          onChanged: (value) {
                            if (value.length >= 10) {
                              setState(() {
                                _endDateController.text = value.substring(0, 10);
                                _updateDaysDifference();
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text("$_daysDifference 일"),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _tripPlace.length, // 저장된 일차 개수 확인해서 출력.
                itemBuilder: (context, index) {
                  int day = index + 1;
                  List<String> places = _tripPlace[day] ?? []; // 기본값을 빈 리스트로 설정
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Color(0xFFEAEBF2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$day일차', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('여행 장소', style: TextStyle(color: Colors.black38, fontSize: 12)),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: places.length,
                            itemBuilder: (context, index2) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 35,
                                      child: TextFormField(
                                        initialValue: places[index2], // index2로 변경
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(color: Colors.grey, width: 1),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.only(left: 10),
                                        ),
                                        onChanged: (text) {
                                          setState(() {
                                            places[index2] = text; // index2로 변경
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        places.removeAt(index2); // index2로 변경
                                      });
                                    },
                                    icon: Icon(Icons.delete_forever_rounded),
                                  ),
                                ],
                              );
                            },
                          ),
                          Container(
                            height: 35,
                            margin: EdgeInsets.only(top: 5),
                            child: SizedBox(
                              width: double.infinity, // 버튼이 가능한 넓게 퍼지도록 설정
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    places.add("");
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),


              // 일차 추가 기능.
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                color: Color(0xFFEAEBF2),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _setIndex++;
                        addData(_setIndex);
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('여행 남기기', style: TextStyle(fontSize: 15, color: Color(0xFF565656)),),
                    SizedBox(height: 5,),
                    TextField(
                      controller: _tripDiaryController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEAEBF2), // 또는 다른 적절한 색상 사용 가능
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('사진', style: TextStyle(fontSize: 15, color: Color(0xFF565656)),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 80,
                              );
                              setState(() {
                                if (pickedFile != null) {
                                  _image1 = File(pickedFile.path);
                                  image1Path = pickedFile.path;
                                } else {
                                  print("No Image Picked");
                                }
                              });
                            },
                            child: Container(
                              height: 180,
                              color: Color(0xFFEAEBF2),
                              child: _image1 != null
                                  ? Image.file(
                                _image1!.absolute,
                                fit: BoxFit.cover,
                              )
                                  : Center(
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 80,
                              );
                              setState(() {
                                if (pickedFile != null) {
                                  _image2 = File(pickedFile.path);
                                  image2Path = pickedFile.path;
                                } else {
                                  print("No Image Picked");
                                }
                              });
                            },
                            child: Container(
                              height: 180,
                              color: Color(0xFFEAEBF2),
                              child: _image2 != null
                                  ? Image.file(
                                _image2!.absolute,
                                fit: BoxFit.cover,
                              )
                                  : Center(
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 20),
                child: InkWell(
                  onTap: () {
                    _saveTrip();
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
                        '수정하기',
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
    );
  }
}