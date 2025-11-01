import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> loginWithGoogle() async {
    try {
      // Step 1: Open your backend's Google login endpoint
      final result = await FlutterWebAuth2.authenticate(
        url: 'https://loginsignup-bzym.onrender.com/oauth2/authorization/google',
        callbackUrlScheme: 'myapp', // must match backend redirect
      );

      // Step 2: Extract JWT token from redirect URL
      final token = Uri.parse(result).queryParameters['token'];

      if (token != null) {
        // Step 3: Save JWT locally for later API calls
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', token);

        // Step 4: Redirect to Home Page
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed: token missing.")),
        );
      }
    } catch (e) {
      debugPrint('Login error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: loginWithGoogle,
          child: const Text("Login with Google"),
        ),
      ),
    );
  }
}
