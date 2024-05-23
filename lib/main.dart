import 'package:flutter/material.dart';
import 'WriteTrip.dart'; // WriteTrip 위젯을 불러옵니다.

void main() => runApp(const BottomSheetApp());

class BottomSheetApp extends StatelessWidget {
  const BottomSheetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff6750a4)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Bottom Sheet Sample')),
        body: WriteTripButton(), // WriteTrip 버튼을 띄웁니다.
      ),
    );
  }
}

class WriteTripButton extends StatelessWidget {
  const WriteTripButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Show WriteTrip Widget'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return WriteTrip(); // WriteTrip 모달 바텀 시트를 띄웁니다.
            },
          );
        },
      ),
    );
  }
}






