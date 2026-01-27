import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/login/login_cubit.dart';
import 'blocs/login/login_state.dart';

class LoginScreen2 extends StatelessWidget {
  const LoginScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginForm(), // Tách ra widget con để code gọn
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng Nhập Bloc")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        
        // BlocConsumer = BlocBuilder + BlocListener
        // Vừa vẽ lại UI (builder), vừa lắng nghe sự kiện (listener)
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            // Xử lý sự kiện 1 lần (SnackBar, Dialog, Navigate)
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error), backgroundColor: Colors.red),
              );
            } else if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đăng nhập thành công!"), backgroundColor: Colors.green),
              );
              // Navigator.pushNamed(context, '/home'); // Chuyển màn hình ở đây
            }
          },
          builder: (context, state) {
            // Vẽ giao diện dựa trên state
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                TextField(
                  controller: _userController,
                  decoration: const InputDecoration(labelText: "Username (admin)", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password (123456)", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<LoginCubit>().login(
                        _userController.text, 
                        _passController.text
                      );
                    },
                    child: const Text("LOGIN"),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}