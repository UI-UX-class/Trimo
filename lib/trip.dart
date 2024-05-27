import 'dart:io';

class Trip {
  String tripName;
  String tripWhere;
  bool isAbroad;
  DateTime tripWhenStart;
  DateTime tripWhenEnd;
  int daysDifference;
  Map<int, List<String>> tripPlace;
  String tripDiary;
  File tripImage1;
  File tripImage2;

  Trip({
    required this.tripName,
    required this.tripWhere,
    required this.isAbroad,
    required this.tripWhenStart,
    required this.tripWhenEnd,
    required this.daysDifference,
    required this.tripPlace,
    required this.tripDiary,
    required this.tripImage1,
    required this.tripImage2,
  });
}