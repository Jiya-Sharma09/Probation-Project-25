import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';



class splashScreen extends StatefulWidget{
  @override 
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>{

  @override
  void initState() {
      super.initState();
      Timer(
        Duration(minutes: 3), 
        (){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              builder: (context) => homeScreen()
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

      backgroundColor: Color.fromARGB(255, 0, 0, 10),
    );
  }
}