import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginEmailPassword() {}

  void loginWtihGoogle() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            children: [
              //email field
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
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

              //password field :

              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter a valid email.';
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

              // login button

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



            ],
          ),
        ),
      ),
    );
  }
}
