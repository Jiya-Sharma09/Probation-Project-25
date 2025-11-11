import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null) {
      final decoded = decodeJWT(token);
      setState(() {
        userId = decoded["_id"] ?? "Unknown ID";
      });
    }
  }

  Map<String, dynamic> decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return {};
    }

    final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return jsonDecode(payload);
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_2_rounded,
            size: 100,
            color: Color(0xFF512D80),
          ),

          const SizedBox(height: 20),

          Text(
            "User ID:",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),

          const SizedBox(height: 5),

          Text(
            userId,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: logoutUser,
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(Color(0xFF512D80)),
            ),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
