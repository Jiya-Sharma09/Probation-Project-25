import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/screens/home_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';




class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
   
}

class _LoginScreenState extends State<LoginScreen>{
  

  Future<void> _loginWithGoogle(BuildContext context)async{
    
      try{

          final urlForGoogleAuth = Uri.parse('');

          final response = await http.get(urlForGoogleAuth);

          if(response.statusCode == 200){
            // yaha status code 200 hai that means successful !! yay !!

            // response body will contain the token i need for my fluttter appppppppppppppppppppp

            final jsonData = jsonDecode(response.body);
            final tokenForAuth = jsonData['token'];
            final storedPref = await SharedPreferences.getInstance();
            await storedPref.setString('token', tokenForAuth);

            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context)=> homeScreen())
            );

          }
          else{



          }
      }catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      }

     
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("LET'S GET YOU IN...", 
            style: TextStyle(fontSize: 23, 
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 243, 185, 40)
            ),
            ),

            ElevatedButton(onPressed:(){ _loginWithGoogle(context);}, child: Text('Login with Google !'))
          ],
        ),
      ),
    );
  }
}