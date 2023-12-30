import 'package:flutter/material.dart';
import 'switch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Variable Switch',
      home: CustomSwitchScreen(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
