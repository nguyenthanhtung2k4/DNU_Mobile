import 'package:flutter/material.dart';
import 'package:widget_base/wiget/layout.dart';
// import 'package:widget_base/wiget/exampleButton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Expandedd(),
    );
  }
}
