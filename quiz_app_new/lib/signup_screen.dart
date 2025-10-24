import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  
  @override
  State<SignupScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKeySignUP = GlobalKey<FormState>();

  Future<void> _SignUp()async{
    if(!_formKeySignUP.currentState!.validate()){

    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: 
      SingleChildScrollView(
        child : Form(
          key: _formKeySignUP,
          child: Column(
          children: [

            SizedBox(
              width: 300,
              child : TextFormField(
                controller: _emailController,

                 decoration: InputDecoration(
                      labelText: 'enter your email',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(251, 240, 209, 224),
                    ),

                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "enter your email";
                  }

                  return null;
                  
                },
              ),
              ),

             SizedBox(
                height: 20,
              ),

              SizedBox(
              width: 300,
              child : TextFormField(
                controller: _passwordController,

                 decoration: InputDecoration(
                  border: OutlineInputBorder(),
                      labelText: 'set your password',
                      filled: true,
                      fillColor: Color.fromARGB(251, 240, 209, 224),
                    ),

                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "enter your email";
                  }

                  return null;
                  
                },
              ),
              ),

              SizedBox(
                height: 20,
              ),

              ElevatedButton(onPressed: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => SignupScreen()
                )
                );
              }, 
              child: Text('Login'),
              ),


            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()
              )
              );
            }, child: Text('Have an account ? go to login page.', style: TextStyle(color: Color.fromARGB(255, 239, 112, 159)),))
          ],
        ),
        )
      ),
      )
    );
  }
}