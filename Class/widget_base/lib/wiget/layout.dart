import 'package:flutter/material.dart';

class Expandedd extends StatefulWidget {
  const Expandedd({super.key});

  @override
  State<Expandedd> createState() => _ExpandeddState();
}

class _ExpandeddState extends State<Expandedd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header cố định
          Container(
            height: 60,
            color: Colors.blue,
            child: const Center(
              child: Text("Header", style: TextStyle(color: Colors.white)),
            ),
          ),
          // Content chiếm phần còn lại
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(title: Text("Item $index"));
              },
            ),
          ),
          // Footer cố định
          Container(
            height: 60,
            color: Colors.grey,
            child: const Center(
              child: Text("Footer", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
