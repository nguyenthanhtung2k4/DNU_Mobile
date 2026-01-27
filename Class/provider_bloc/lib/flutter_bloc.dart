import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit<int>: State quản lý là kiểu int
class CounterCubit extends Cubit<int> {
  // Khởi tạo giá trị ban đầu là 0
  CounterCubit() : super(0);

  // Logic tăng
  void increment() => emit(state + 1);

  // Logic giảm
  void decrement() => emit(state - 1);
}
