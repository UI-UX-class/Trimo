import 'package:flutter/material.dart';
import 'ShowTrip.dart';

class TripList extends StatelessWidget {
  final List<Map<String, dynamic>> trips = [
    {'id': 11, 'title': 'Trip to Paris'},
    {'id': 2, 'title': 'Trip to New York'},
    // 더 많은 항목 추가 가능
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip List'),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(trips[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowTrip(tripId: trips[index]['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}