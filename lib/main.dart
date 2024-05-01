import 'package:chat_app/cubits/cubit/auth_cubit.dart';
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
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            background: Colors.grey.shade100,
            primary: Colors.grey.shade500,
            secondary: Colors.grey.shade300,
            tertiary: Colors.white,
            inversePrimary: Colors.grey.shade900,
          ),
        ),
        routes: {
          LoginPage.id: (context) => const LoginPage(),
          HomePage.id: (context) => const HomePage(),
          ChatPage.id: (context) => const ChatPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          SettingsPage.id: (context) => const SettingsPage(),
        },
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return const ChatPage();
        //     } else {
        //       return const LoginPage();
        //     }
        //   },
        // ),
        initialRoute: HomePage.id,
      ),
    );
  }
}
