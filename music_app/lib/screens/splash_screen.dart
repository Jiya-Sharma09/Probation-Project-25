import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_app/screens/auth_gate.dart';
//import 'package:music_app/screens/login_screen.dart';


class SplashScreen extends StatefulWidget{
  @override 
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
      super.initState();
      Timer(
        Duration(seconds: 5), 
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
          backgroundImage: AssetImage('assets/images/logo.jpg'),
          radius: 100,
          
        ),
      ),

      backgroundColor: Color.fromARGB(0, 0, 0, 0),
    );
  }
}