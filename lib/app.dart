import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart'; // Ensure this file exists and contains a SignInScreen class
import 'screens/sign_up_screen.dart'; // Ensure this file exists and contains a SignUpScreen class
import 'screens/chat_screen.dart'; // Ensure this file exists and contains a ChatScreen class

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const SignInScreen(), // Added const before the constructor
        '/signup': (context) =>
            const SignUpScreen(), // Added const before the constructor
        '/chat': (context) =>
            const ChatScreen(), // Added const before the constructor
      },
    );
  }
}
