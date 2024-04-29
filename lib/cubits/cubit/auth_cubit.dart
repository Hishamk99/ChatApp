import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isLogin = true;
  registerOrLogin() {
    isLogin = !isLogin;
    if (isLogin) {
      emit(AuthLogin());
    } else {
      emit(AuthRegister());
    }
  }
}
