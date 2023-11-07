import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart'; // Make sure the path matches the location of your files
import 'screens/sign_up_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const MyApp()); // Use const with the constructor
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Add Key parameter

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
            const SignInScreen(), // Use const with the constructor
        '/signup': (context) =>
            const SignUpScreen(), // Use const with the constructor
        '/chat': (context) =>
            const ChatScreen(), // Use const with the constructor
      },
    );
  }
}
