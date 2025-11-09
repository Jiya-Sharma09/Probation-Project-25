import 'package:flutter/material.dart';
import 'package:music_app/service/user_api.dart';
import 'package:music_app/models/user_model.dart';
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

    try {
      User? user = await ApiServiceUser().signup(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup successful! Welcome ${user.username}'),
          ),
        );

        //  Navigate to login screen or home after signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(228, 0, 0, 0),
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
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 248, 248)
                    ),
                    controller: _usernameController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter your username!'
                        : null,
                    decoration: const InputDecoration(
                      hintText: 'Enter your username',
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
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 248, 248)
                    ),
                    controller: _emailController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter a valid email!'
                        : null,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
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
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 248, 248)
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter your password!'
                        : null,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
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
                    : SizedBox(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              const Color(0xFF512D80),
                            ),
                          ),
                          onPressed: signupUser,
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
