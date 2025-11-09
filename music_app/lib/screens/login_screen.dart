import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page_structure.dart';
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

  bool _isLoading = false; 

  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://loginsignup-2.onrender.com/api/auth/login'),
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
            MaterialPageRoute(builder: (context) => PageStruct()),
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(215, 0, 0, 0),
      
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Kadence',
                      style: TextStyle(
                        fontFamily: 'Playfair',
                        fontSize: 40,
                        color: Color(0xFF512D80),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // email field
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: TextFormField(
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 248, 248)
                    ),
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
                          color: Color(0xFF512D80),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // password field
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: TextFormField(
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 248, 248)
                    ),
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
                          color: Color(0xFF512D80),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),


              // login button : 
                
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 3,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              // if (_loginFormKey.currentState!.validate()) {
                              //   setState(() => _isLoading = true);
                              //   await loginUser(
                              //     context,
                              //     _emailController.text.trim(),
                              //     _passwordController.text.trim(),
                              //   );
                              //   setState(() => _isLoading = false);
                              // }
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PageStruct()));
                            },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xFF512D80)
                        ),
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
                              'login ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 245, 243, 243),
                              ),
                            ),
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
      ),
    );
  }
}
