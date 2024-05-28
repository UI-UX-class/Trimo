import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip List'),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          // Convert the image path to a File object
          String imagePath = trips[index]['image_first'];
          File imageFile = File(imagePath);

          return ListTile(
            leading: imagePath != null && imageFile.existsSync()
                ? Image.file(imageFile)
                : Icon(Icons.image),
            title: Text(trips[index]['title']),
            subtitle: Text('${trips[index]['country']} - ${trips[index]['start_date']} to ${trips[index]['end_date']}'),
          );
        },
      ),
    );
  }
}