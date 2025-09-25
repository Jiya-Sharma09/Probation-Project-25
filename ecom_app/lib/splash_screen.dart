import 'package:ecom_app/page_structure.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // this package is for adding timer 


class SplashScreen extends StatefulWidget{

  @override
  State <SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State <SplashScreen> {

  // init function : 

  @override
  void initState() {
    
    super.initState();

    // timer 
    Timer(Duration(seconds: 4), (){
      Navigator.pushReplacement(context, 
      MaterialPageRoute(
        builder: (context) => PageStruct(),
        )
      );
    }
    );
  }

  // building how the splash screen will actually look :

  @override
  Widget build(BuildContext  context){
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.png') , 
          backgroundColor: Color.fromARGB(255, 245, 167, 206),
          radius : 50,)
      
      ),
    );
  }

}