import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_app/models/user_model.dart';
import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User?> userFuture;

  final String baseUrl = "https://loginsignup-2.onrender.com";

  @override
  void initState() {
    super.initState();
    userFuture = fetchUserProfile();
  }

  // ✅ Fetch Logged-in User Profile
  Future<User?> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) return null;

    final url = Uri.parse("$baseUrl/api/auth/me");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data["user"]);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Profile error: $e");
      return null;
    }
  }

  // ✅ Logout Function (Deletes Token + Navigates to Login)
  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token"); // delete stored token

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<User?>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Color.fromARGB(255, 174, 135, 26),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Text(
              "No user data found",
              style: TextStyle(color: Colors.white),
            );
          }

          final user = snapshot.data!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_2_rounded,
                size: 100,
                color: Color.fromARGB(255, 174, 135, 26),
              ),

              const SizedBox(height: 20),

              Text(
                user.username,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: logoutUser,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 174, 135, 26),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
