import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signUPkey = GlobalKey<FormState>();

  void signupUser(
    BuildContext context, 
    String email, 
    String password
  ) async {
    //try{}catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signUPkey,
          child: Column(
            children: [
              // email
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter a valid email id !";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 174, 135, 26),
                    ),
                  ),
                ),
              ),

              // space
              SizedBox(height: 10),

              // password
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter your password !";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 174, 135, 26),
                    ),
                  ),
                ),
              ),

              // space
              SizedBox(height: 10),

              // signup button
              ElevatedButton(onPressed: () {}, child: Text('Sign up')),

              SizedBox(height: 25),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("Have an account ? Login "),
              ),
            ],
          ),
        ),
      ),

      backgroundColor: Color.fromARGB(0, 0, 0, 0),
    );
  }
}
