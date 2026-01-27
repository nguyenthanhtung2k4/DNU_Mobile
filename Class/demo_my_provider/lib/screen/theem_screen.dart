import 'package:demo_my_provider/provider/theem_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProv = context.watch<ThemeProvider>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("CÀI ĐẶT GIAO DIỆN", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text(
            "Hello World!", 
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Chế độ tối:"),
              Switch(
                value: themeProv.isDarkMode,
                onChanged: (value) {
                  themeProv.toggleTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}