import 'package:flutter/material.dart';
import 'package:navigation/screens/home_screens.dart';
import 'package:navigation/screens/detail_sceens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 👇 khai báo initialRoute
      initialRoute: '/',
      // 👇 định nghĩa các route
      routes: {
        '/': (context) => const HomeScreens(),
        '/detail': (context) => const DetailSceens(),
      },
    );
  }
}
