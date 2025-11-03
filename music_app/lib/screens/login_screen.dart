import 'dart:convert';

//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  // i will call this function once api from backend (arnav) is reaady
  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://loginsignup-bzym.onrender.com/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data['token'];
        if (token != null) {
          Map<String, dynamic> decodedToken = _decodeJWT(token);
          print('Decoded token: $decodedToken');

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => homeScreen()),
          );
        } else {
          _showError(context, 'Token missing in response');
        }
      } else {
        _showError(context, 'Invalid credentials or server error');
      }
    } catch (e) {
      _showError(context, 'Error: $e');
    }
  }

  Map<String, dynamic> _decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = utf8.decode(
      base64Url.decode(base64Url.normalize(parts[1])),
    );
    return jsonDecode(payload);
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // function for google auth : 

  void loginWtihGoogle() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              //email field
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 174, 135, 26),
                    ),
                  ),
                ),
              ),

              // spacing :
              SizedBox(height: 10),

              //password field :
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password.';
                  }
                  return null;
                },
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 174, 135, 26),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // login button :
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => homeScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color.fromARGB(255, 174, 135, 26),
                      ),
                    ),
                    child: Text('login'),
                  ),
                ),
              ),

              SizedBox(height: 25),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text("Don't have an account ? sign up "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
