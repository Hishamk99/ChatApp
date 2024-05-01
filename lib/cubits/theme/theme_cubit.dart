import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  ThemeData themeData = lightTheme;
  bool isDarkMode() {
    return themeData == darkTheme;
  }

  void toggleTheme() {
    if (themeData == lightTheme) {
      themeData = darkTheme;
      emit(ThemeDark());
    } else {
      themeData = lightTheme;
      emit(ThemeLight());
    }
  }
}
