import 'package:flutter/material.dart';

class DetailSceens extends StatelessWidget {
  const DetailSceens({super.key});

  @override
  Widget build(BuildContext context) {
    final String productName =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Screen")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Detail Screen: $productName"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
