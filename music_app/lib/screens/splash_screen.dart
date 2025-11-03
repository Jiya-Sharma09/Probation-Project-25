import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_app/screens/auth_gate.dart';
import 'package:music_app/screens/login_screen.dart';


class splashScreen extends StatefulWidget{
  @override 
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>{

  @override
  void initState() {
      super.initState();
      Timer(
        Duration(seconds: 3), 
        (){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              builder: (context) => AuthGate()
              ),
          );
          
          }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.png'),
          radius: 100,
          
        ),
      ),

      backgroundColor: Color.fromARGB(0, 0, 0, 0),
    );
  }
}