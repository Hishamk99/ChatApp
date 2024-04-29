import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> registerUser(
      {required String email, required String pass}) async {
    emit(AuthRegisterLoading());

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      emit(AuthRegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          AuthRegisterFailure(
            errorMessage: 'The password provided is too weak.',
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          AuthRegisterFailure(
            errorMessage: 'The account already exists for that email.',
          ),
        );
      }
    } catch (e) {
      emit(
        AuthRegisterFailure(
          errorMessage: 'There was an error, please try again.',
        ),
      );
    }
  }

  Future<void> loginUser() async {}
}
