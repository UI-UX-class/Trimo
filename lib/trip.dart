import 'dart:convert';

class Trip {
  String tripName;
  String tripWhere;
  bool isAbroad;
  DateTime tripWhenStart;
  DateTime tripWhenEnd;
  int daysDifference;
  Map<int, List<String>> tripPlace;
  String tripDiary;
  String tripImage1;
  String tripImage2;

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

  Map<String, dynamic> toJson() {
    return {
      'tripName': tripName,
      'tripWhere': tripWhere,
      'isAbroad': isAbroad,
      'tripWhenStart': tripWhenStart.toIso8601String(),
      'tripWhenEnd': tripWhenEnd.toIso8601String(),
      'daysDifference': daysDifference,
      'tripPlace': tripPlace.map((key, value) => MapEntry(key.toString(), value)),
      'tripDiary': tripDiary,
      'tripImage1': tripImage1,
      'tripImage2': tripImage2,
    };
  }
}

