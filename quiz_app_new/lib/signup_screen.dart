import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  
  @override
  State<SignupScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: 
      SingleChildScrollView(
        child: Column(
          children: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()
              )
              );
            }, child: Text('Have an account ? go to login page.', style: TextStyle(color: Color.fromARGB(255, 244, 41, 115)),))
          ],
        ),
      ),
      )
    );
  }
}