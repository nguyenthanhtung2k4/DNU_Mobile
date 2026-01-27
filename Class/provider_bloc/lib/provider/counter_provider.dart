// lib/providers/counter_provider.dart
import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners(); // Báo tin: "Dữ liệu đã thay đổi!"
  }
  
  void decrement() {
    _count--;
    notifyListeners();
  }
}
