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
      'title': tripName,
      'country': tripWhere,
      'domestic': isAbroad,
      'start_date': tripWhenStart.toIso8601String(),
      'end_date': tripWhenEnd.toIso8601String(),
      'days': daysDifference,
      'trip_place': Map.fromIterable(tripPlace.keys, key: (key) => key.toString(), value: (key) => tripPlace[key]),
      'contents': tripDiary,
      'image_first': tripImage1,
      'image_second': tripImage2,
    };
  }
}