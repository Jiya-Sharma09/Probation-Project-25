import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/service/api_config.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signUPkey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> signupUser() async {
    if (!_signUPkey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final url = "${ApiConfig.activeBaseUrl}/api/auth/signup";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": _usernameController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Signup successful! Please login."),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Signup failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ✅ Same gradient as home page / page struct
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.15, 1.0],
          colors: [
            Color(0xFF7A43BF), // top glow
            Color(0xFF512D80), // deep violet
            Color(0xFF000000), // black
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _signUPkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ✅ Welcome message
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Sign up new user,\nWe're glad you are here!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // ✅ Username
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _usernameController,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter username"
                          : null,
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: const TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ Email
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _emailController,
                      validator: (value) =>
                          value == null || value.isEmpty ? "Enter email" : null,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ Password
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) =>
                          value == null || value.isEmpty ? "Enter password" : null,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ✅ Signup button
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: signupUser,
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                  const SizedBox(height: 40),

                  // ✅ Login link
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Have an account? Login",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
