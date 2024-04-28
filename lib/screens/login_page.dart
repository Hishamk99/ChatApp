import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 70,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            'Welcome back you\'ve been missed!',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomTextField(
            hintText: 'Enter your email',
          ),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(
            hintText: 'Enter your password',
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: 'Login',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
