import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Home Screen"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: "tungnt", // truyền data
                );
              },
              child: const Text("Open Detail Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
