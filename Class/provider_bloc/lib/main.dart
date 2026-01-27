import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_bloc/bai3_login.dart';
// import 'package:provider_bloc/bai3_login_provider.dart';
import 'cubits/theme_cubit.dart';
// import 'bai1_counter.dart'; // Tận dụng lại bài 1

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Cung cấp ThemeCubit cho toàn bộ app
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Bloc Demo',
            theme: theme, // Theme thay đổi theo state
            home:  const HomePage(),
          );
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Theme Switcher")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              child: const Text("Đổi Giao Diện"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen2()),
                );
              },
              child: const Text("Qua Bài 3"),
            ),
          ],
        ),
      ),
    );
  }
}
