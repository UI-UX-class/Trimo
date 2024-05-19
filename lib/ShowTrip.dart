import 'package:flutter/material.dart';

class ShowTrip extends StatefulWidget {
  const ShowTrip({super.key});

  @override
  State<ShowTrip> createState() => _ShowTripState();
}

class _ShowTripState extends State<ShowTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("하이하이"),
      ),
      body: Column(
        children: <Text>[
          Text("게시물 보는데임")
        ],
      ),
    );
  }
}
