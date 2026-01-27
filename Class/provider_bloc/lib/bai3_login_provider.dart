// lib/bai3_login_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_bloc/provider/login_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: const LoginForm(),
    );
  }
}



class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>(); // ❌ Rebuild toàn bộ

    return Scaffold(
      appBar: AppBar(title: const Text("Đăng Nhập Provider")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ❌ Phải check nhiều điều kiện
            if (loginProvider.isLoading)
              const CircularProgressIndicator()
            else ...[
              const Icon(Icons.person, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              TextField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: "Username (admin)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password (123456)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final provider = context.read<LoginProvider>();
                    provider
                        .login(_userController.text, _passController.text)
                        .then((_) {
                          // ❌ Phải check status sau khi login
                          if (provider.isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Đăng nhập thành công!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Navigator.pushNamed(context, '/home');
                          } else if (provider.isFailure) {
                            // ❌ Phải check error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  provider.error ?? "Lỗi không xác định",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        });
                  },
                  child: const Text("LOGIN"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
