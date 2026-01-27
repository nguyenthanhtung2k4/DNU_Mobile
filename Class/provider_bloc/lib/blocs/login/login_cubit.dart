import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String username, String password) async {
    // 1. Bắn ra trạng thái Loading
    emit(LoginLoading());

    // 2. Giả lập gọi API mất 2 giây
    await Future.delayed(const Duration(seconds: 2));

    // 3. Kiểm tra kết quả
    if (username == "admin" && password == "123456") {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure("Sai tài khoản hoặc mật khẩu!"));
    }
  }
}
