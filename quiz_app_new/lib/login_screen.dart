import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _jiyaKey = GlobalKey<FormState>();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; 
  String? _errorMessage = '';


  void _login()async{

    if(!_jiyaKey.currentState!.validate()){
      // we entered this code when the validators say that the entered input bu the user is not valid.
      return ;
    }

    // yaha hamne sab validators ko run kar liya and they return valid input
    
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), 
      password: _passwordController.text.trim());
    }on FirebaseAuthException catch(e){
      setState(() {
        _errorMessage = e.message;
      });
    }catch(e){
      _errorMessage = 'an unexpected error ocurred !';
    }

    if(mounted){
      setState(() {
        _errorMessage= 'anuexpected error has occured';
      });
    }


  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :
      Center
      (child : SingleChildScrollView(
        child: Form(
          child: Column(
            children: [

              SizedBox(
                height: 60,
                child: Text('Quiziko', style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 233, 78, 145)), ),
              ),

              SizedBox(
                height: 10,
              ),

            SizedBox(
              width: 300,
              child: 
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email', 
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 239, 53, 130),
                      width: 5
                    )
                  ),
                  filled: true, 
                  fillColor: Color.fromARGB(255, 245, 197, 217)),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your password.';
                  }

                  return null;
                } ,

              ),
            ),

            SizedBox(
                height: 10,
              ),


            SizedBox(
              width:  300,
              child: 
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password', 
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 239, 53, 130),
                      width: 5
                    )
                  ),
                  filled: true, 
                  fillColor: Color.fromARGB(255, 245, 197, 217)

                  ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'please enter your password';
                  }

                  return null;

                } ,

              ),
            ),
              Container(
                height: 10,
              ),

              _isLoading ?
              CircularProgressIndicator()
              : ElevatedButton(onPressed: _login, child: Text('Login')),

              SizedBox(
                height: 20,
              ),


              // goinggggggggg to sign up screeenn yay

              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()),
                );
              }, child: Text("Don't have an account ? then sign up"),),
            ],
        ),
        ) ,      
      ),),

      backgroundColor: Color.fromARGB(251, 247, 247, 247)
      );
  }
}