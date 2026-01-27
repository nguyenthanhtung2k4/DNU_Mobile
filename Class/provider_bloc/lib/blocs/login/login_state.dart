abstract class LoginState {}

class LoginInitial extends LoginState {}      // Trạng thái ban đầu
class LoginLoading extends LoginState {}      // Đang xử lý
class LoginSuccess extends LoginState {}      // Thành công
class LoginFailure extends LoginState {       // Thất bại
  final String error;
  LoginFailure(this.error);
}