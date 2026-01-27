import 'package:demo_my_provider/provider/count_provider.dart';
import 'package:demo_my_provider/provider/student_provider.dart';
import 'package:demo_my_provider/provider/theem_provider.dart'; // Import thêm
import 'package:demo_my_provider/screen/home_screen.dart';
import 'package:demo_my_provider/screen/theem_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Đăng ký ở đây
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Lắng nghe sự thay đổi của ThemeProvider để đổi màu toàn bộ App
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text("DNU Mobile Project")),
        body: SingleChildScrollView( // Chống lỗi tràn màn hình nếu nhiều widget
          child: Center(
            child: Column(
              children: const [
                HomeScreen(),   // Chức năng 1
                Divider(height: 50, thickness: 2), // Đường kẻ phân cách
                ThemeScreen(),  // Chức năng 2
              ],
            ),
          ),
        ),
      ),
    );
  }
}