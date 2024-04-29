import 'package:chat_app/cubits/cubit/auth_cubit.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLogin) {
              return const RegisterPage();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
