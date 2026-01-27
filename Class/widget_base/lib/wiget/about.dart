import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int count = 0;
  void counts() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("taoday"), backgroundColor: Colors.red),
      body: Center(
        child: Column(
          children: [
            Text("Inint.. $count"),
            TextButton(onPressed: counts, child: Text("ok")),
            TextButton(
              onPressed: () {
                setState(() {
                count = 0;
                  
                });
              },
              child: Text("Clear"),
            ),
          ],
        ),
      ),
    );
  }
}
