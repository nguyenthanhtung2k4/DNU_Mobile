// lib/providers/login_provider.dart
import 'package:flutter/material.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginProvider extends ChangeNotifier {
  LoginStatus _status = LoginStatus.initial; // ❌ Enum
  String? _error; // ❌ Phải lưu error riêng

  // ❌ Phải tạo nhiều getters
  LoginStatus get status => _status;
  String? get error => _error;
  bool get isLoading => _status == LoginStatus.loading;
  bool get isSuccess => _status == LoginStatus.success;
  bool get isFailure => _status == LoginStatus.failure;

  Future<void> login(String username, String password) async {
    _status = LoginStatus.loading;
    _error = null; // ❌ Phải reset error
    notifyListeners(); // ❌ Không rõ đang emit State nào

    await Future.delayed(Duration(seconds: 2));

    if (username == "admin" && password == "123456") {
      _status = LoginStatus.success;
      _error = null;
    } else {
      _status = LoginStatus.failure;
      _error = "Sai tài khoản hoặc mật khẩu!"; // ❌ Phải set error
    }
    notifyListeners(); // ❌ Vẫn không rõ đang emit State nào
  }
}
