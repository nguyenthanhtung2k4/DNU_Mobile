import 'package:demo_my_provider/provider/count_provider.dart';
import 'package:demo_my_provider/provider/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CountProvider>().count;
    final age = context.watch<StudentProvider>().age;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("QUẢN LÝ ĐẾM", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Giá trị hiện tại: $count", style: const TextStyle(fontSize: 18)),
          Text("Tuổi sinh viên: $age", style: const TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<CountProvider>().increase();
                  context.read<StudentProvider>().increase();
                },
                child: const Text("Tăng +1"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => context.read<CountProvider>().reset(),
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}