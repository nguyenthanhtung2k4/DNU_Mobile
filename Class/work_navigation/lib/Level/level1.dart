
import 'package:flutter/material.dart';

// --- MÀN HÌNH 1 ---
class Level1 extends StatelessWidget {
  const Level1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Màn hình 1 (Gốc)")),
      backgroundColor: Colors.blue[50], // Màu xanh nhạt
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, 
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text("Sang Màn hình 2 👉", style: TextStyle(fontSize: 18)),
          onPressed: () {
            // Lệnh chuyển màn hình: PUSH
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Screen2()),
            );
          },
        ),
      ),
    );
  }
}

// --- MÀN HÌNH 2 ---
class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Màn hình 2"),
        backgroundColor: Colors.orange, // Đổi màu AppBar để dễ nhận biết
      ),
      backgroundColor: Colors.orange[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Đây là màn hình 2", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
              child: const Text("👈 Quay lại (Pop)"),
              onPressed: () {
                // Lệnh quay về: POP
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}