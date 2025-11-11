import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page_structure.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return snapshot.data! ? PageStruct() : LoginScreen();
      },
    );
  }
}
