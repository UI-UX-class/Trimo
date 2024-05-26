import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './trip.dart';

enum Location {
  domestic,
  abroad,
}

class WriteTrip extends StatefulWidget {
  const WriteTrip({Key? key}) : super(key: key);

  @override
  State<WriteTrip> createState() => _WriteTripState();
}

class _WriteTripState extends State<WriteTrip> {
  late TextEditingController _tripNameController;
  late TextEditingController _tripWhereController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _tripDiaryController;
  int _daysDifference = 0;

  int _setIndex = 1; // 1일차, 2일차 구분하는 index
  Location _selectedLocation = Location.domestic; // 변수 초기화
  Map<int, List<String>> _tripPlace = {}; // 1일차 장소, 2일차 장소 자료 구조

  final picker = ImagePicker();
  File? _image1;
  File? _image2; // 가져온 사진들을 보여주기 위한 변수

  @override
  void initState() {
    super.initState();
    _tripNameController = TextEditingController();
    _tripWhereController = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _tripDiaryController = TextEditingController();
    _tripPlace[1] = ["출발", "도착"];
  }

  // 일차 추가 함수
  void addData(int index) {
    setState(() {
      _tripPlace[index] = ["출발", "도착"];
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

  // 이미지 가져오기 함수
  Future getImageGallery(int index) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        if (index == 1) {
          _image1 = File(pickedFile.path);
        } else {
          _image2 = File(pickedFile.path);
        }
      } else {
        print("No Image Picked");
      }
    });
  }

  // 여행 정보 저장 함수
  void _saveTrip() {
    final newTrip = Trip(
      tripName: _tripNameController.text,
      tripWhere: _tripWhereController.text,
      isAbroad: _selectedLocation == Location.abroad,
      tripWhenStart: DateTime.parse(_startDateController.text),
      tripWhenEnd: DateTime.parse(_endDateController.text),
      daysDifference: _daysDifference,
      tripPlace: _tripPlace,
      tripDiary: _tripDiaryController.text,
      tripImage1: _image1 ?? File(''), // null일 경우 기본값 사용
      tripImage2: _image2 ?? File(''), // null일 경우 기본값 사용
    );

    print("저장된 여행 정보: ${newTrip.tripImage1}");
    print("저장된 여행 정보: ${newTrip.tripImage2}");
    // 여행 정보 저장 후 필요한 곳에서 사용
    Navigator.pushReplacementNamed(context, '/showTrip');
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
                          onChanged: (_) => _updateDaysDifference(),
                        ),
                      ),
                    ),
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
                          onChanged: (_) => _updateDaysDifference(),
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
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color(0xFFEAEBF2),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$day일차', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('여행 장소', style: TextStyle(color: Colors.black38, fontSize: 12),),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _tripPlace[day]!.length,
                              itemBuilder: (context, index2) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 35,
                                        child: TextField(
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
                                              _tripPlace[day]![index2] = text;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _tripPlace[day]!.removeAt(index2);
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
                                      _tripPlace[day]!.add("");
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero, // 모서리를 각지게 설정
                                    ),
                                  ),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
                                XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  setState(() {
                                    getImageGallery(1);
                                  });
                                }
                              },
                              child: Container(
                                  height: 180,
                                  color: Color(0xFFEAEBF2),
                                  child: _image1 != null
                                      ? Image.file(
                                    _image1!.absolute,
                                    fit: BoxFit.cover,
                                  )
                                      :Center(
                                    child: Icon(Icons.add_photo_alternate_outlined, size: 30, color: Colors.grey,),
                                  )
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () async {
                                XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  setState(() {
                                    getImageGallery(2);
                                  });
                                }
                              },
                              child: Container(
                                  height: 180,
                                  color: Color(0xFFEAEBF2),
                                  child: _image2 != null
                                      ? Image.file(
                                    _image2!.absolute,
                                    fit: BoxFit.cover,
                                  )
                                      :Center(
                                    child: Icon(Icons.add_photo_alternate_outlined, size: 30, color: Colors.grey,),
                                  )
                              )
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
                    // _saveTrip();
                    Navigator.pushReplacementNamed(context, '/showTrip');
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
                        '만들기',
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