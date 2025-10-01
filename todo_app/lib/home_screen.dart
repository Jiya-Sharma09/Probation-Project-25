import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Function to handle user logout
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    // After logout, the AuthGate will automatically navigate to the LoginScreen.
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user from FirebaseAuth. Can be null.
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        // actions are the widgets displayed at the end of the AppBar.
        actions: [
          // This is our logout button.
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout', // Shows a tooltip on long press
            onPressed: () {
              // Show a confirmation dialog before logging out.
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          _logout(); // Call the logout function
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        // Display a welcome message with the user's email if available.
        child: Text(
          'Welcome, ${user?.email ?? 'User'}!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
