import 'package:chat_app/cubits/auth/auth_cubit.dart';
import 'package:chat_app/cubits/theme/theme_cubit.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/home_page.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthCubit()),
    BlocProvider(create: (context) => ThemeCubit()),
  ], child: const ChatApp()));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: BlocProvider.of<ThemeCubit>(context).themeData,
          routes: {
            LoginPage.id: (context) => const LoginPage(),
            HomePage.id: (context) => const HomePage(),
            ChatPage.id: (context) => const ChatPage(),
            RegisterPage.id: (context) => const RegisterPage(),
            SettingsPage.id: (context) => const SettingsPage(),
          },
          initialRoute: HomePage.id,
        );
      },
    );
  }
}
