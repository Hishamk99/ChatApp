import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> registerUser(
      {required String email,
      required String pass,
      required String confirmedPass}) async {
    emit(AuthRegisterLoading());

    try {
      if (pass != confirmedPass) {
        emit(
          AuthRegisterFailure(
            errorMessage: 'Wrong Password',
          ),
        );
      } else {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);

        firestore.collection('Users').doc(user.user!.uid).set({
          'uid': user.user!.uid,
          'Email': email,
          'Password': pass,
        });
        emit(AuthRegisterSuccess());
      }
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

  getEmail({required String email}) {
    return email;
  }

  Future<void> loginUser({required String email, required String pass}) async {
    emit(AuthLoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      firestore.collection('Users').doc(user.user!.uid).set({
        'uid': user.user!.uid,
        'Email': email,
        'Password': pass,
      });
      emit(AuthLoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          AuthRegisterFailure(
            errorMessage: 'user-not-found',
          ),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          AuthLoginFailure(
            errorMessage: 'passwords don\' match!',
          ),
        );
      }
    } catch (e) {
      emit(
        AuthLoginFailure(
          errorMessage: 'There was an error, please try again.',
        ),
      );
    }
  }
}
