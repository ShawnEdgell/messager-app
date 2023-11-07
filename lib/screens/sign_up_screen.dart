import 'package:flutter/material.dart';
import 'package:messager_app/services/pocketbase_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  // Renamed to make it public
  final PocketBaseService _pocketBaseService = PocketBaseService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      await _pocketBaseService.signUp(email, password);
      if (mounted) {
        // Use mounted to check if the Widget is still in the widget tree
        Navigator.of(context).pushReplacementNamed('/chat');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')), // Use const for Text
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
              onPressed: _signUp,
              child: const Text('Sign Up'), // Use const
            ),
            TextButton(
              onPressed: () {
                // Use a synchronous operation to avoid async gaps with BuildContext
                Navigator.of(context).pop();
              },
              child:
                  const Text('Already have an account? Sign in'), // Use const
            ),
          ],
        ),
      ),
    );
  }
}
