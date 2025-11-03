import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null; // true if user has a stored JWT
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // show splash or loading
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data == true) {
          // user already logged in
          return homeScreen();
        } else {
          // user not logged in
          return LoginScreen();
        }
      },
    );
  }
}
