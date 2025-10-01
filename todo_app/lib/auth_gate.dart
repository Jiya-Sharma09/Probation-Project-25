import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder listens for changes in a stream and rebuilds the UI when new data arrives.
    return StreamBuilder<User?>(
      // We listen to the authStateChanges stream from FirebaseAuth.
      // This stream emits a User object when the user logs in, and null when they log out.
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. If the snapshot is still waiting for data, show a loading indicator.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. If the snapshot has data, it means the user is logged in.
        if (snapshot.hasData) {
          // The user is logged in, so we show the HomeScreen.
          return const HomeScreen();
        }

        // 3. If the snapshot has no data, it means the user is logged out.
        // The user is not logged in, so we show the LoginScreen.
        return const LoginScreen();
      },
    );
  }
}
