import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/service/api_config.dart';
//import 'package:shared_preferences/shared_preferences.dart';
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

  // ✅ NEW: Direct API call (no user_api.dart needed)
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
        // ✅ Show success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Signup successful! Please login."),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(227, 36, 36, 36),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _signUPkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Username
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _usernameController,
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter username" : null,
                    decoration: const InputDecoration(
                      hintText: "Enter your username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Email
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _emailController,
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter email" : null,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter password" : null,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Signup Button
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color(0xFF512D80),
                          ),
                        ),
                        onPressed: signupUser,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                const SizedBox(height: 40),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text("Have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
