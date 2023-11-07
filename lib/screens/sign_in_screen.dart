import 'package:flutter/material.dart';
import 'package:messager_app/services/pocketbase_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() =>
      SignInScreenState(); // Made public by removing the underscore
}

class SignInScreenState extends State<SignInScreen> {
  final PocketBaseService _pocketBaseService =
      PocketBaseService(); // Make sure this is used

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    // The _pocketBaseService should be used here for signing in.
    try {
      await _pocketBaseService.signIn(
        _emailController.text,
        _passwordController.text,
      );
      // Navigate to the chat screen or home screen upon successful sign-in
    } catch (e) {
      // Handle the error, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')), // Use const for Text
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Use const for EdgeInsets
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Email'), // Use const
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration:
                  const InputDecoration(labelText: 'Password'), // Use const
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'), // Use const
            ),
            // ... other widgets
          ],
        ),
      ),
    );
  }
}
