import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page_structure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';
import 'package:music_app/service/api_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> loginUser() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.activeBaseUrl}/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data["token"];

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => PageStruct()),
          );
        } else {
          _showError("Token missing in response");
        }
      } else {
        _showError("Invalid credentials");
      }
    } catch (e) {
      _showError("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(227, 36, 36, 36),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Muziko',
                      style: TextStyle(
                        fontFamily: 'Playfair',
                        fontSize: 40,
                        color: Color(0xFF512D80),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // email
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'email',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // password
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your password.' : null,
                    decoration: InputDecoration(
                      hintText: 'password',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // ✅ login button using real API
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF512D80),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "login",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),

                SizedBox(height: 25),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                    );
                  },
                  child: Text("Don't have an account? Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
