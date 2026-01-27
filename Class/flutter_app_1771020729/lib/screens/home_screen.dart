import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App - 1771020729',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: đi Menu
              },
              child: const Text('Xem Menu'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: đi Đặt bàn của tôi
              },
              child: const Text('Đặt bàn của tôi'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Logout
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
