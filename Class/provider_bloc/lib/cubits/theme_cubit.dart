import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State ở đây là ThemeData luôn cho tiện
class ThemeCubit extends Cubit<ThemeData> {
  // Mặc định là Light Theme
  ThemeCubit() : super(ThemeData.light());

  void toggleTheme() {
    // Nếu đang là sáng thì chuyển tối, ngược lại
    if (state.brightness == Brightness.light) {
      emit(ThemeData.dark());
    } else {
      emit(ThemeData.light());
    }
  }
}
