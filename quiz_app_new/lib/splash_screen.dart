import 'dart:async';

import 'package:flutter/material.dart';
import 'auth_gate.dart';

class SplashScreen extends StatefulWidget{
  
  @override
  State <SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State <SplashScreen>{

  @override void initState() {
    
    super.initState();

    Timer(Duration(seconds: 3), 
    (){
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => AuthGate()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          backgroundColor: Color.fromARGB(255, 241, 163, 197),
          child: Center(
            child: Text('Quiziko'),
          ),
        ),
      ),
    );
  }
}