import 'package:chat_app/cubits/cubit/auth_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, pass, confirmedPass;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterLoading) {
          isLoading = true;
        } else if (state is AuthRegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage, Colors.red);
        } else if (state is AuthRegisterSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, ChatPage.id);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Icon(
                          Icons.message,
                          size: 70,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Let\'s create an account',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          onSaved: (val) {
                            email = val;
                          },
                          hintText: 'Enter your email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          onSaved: (val) {
                            pass = val;
                          },
                          hintText: 'Enter your password',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          onSaved: (val) {
                            confirmedPass = val;
                          },
                          hintText: 'Confirm your password',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: 'Register',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              BlocProvider.of<AuthCubit>(context).registerUser(
                                email: email!,
                                pass: pass!,
                                confirmedPass: confirmedPass!,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, LoginPage.id);
                              },
                              child: Text(
                                'Login now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
