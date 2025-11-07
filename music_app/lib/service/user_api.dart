import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:music_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';

class ApiServiceUser {
  final baseUrl = ApiConfig.activeBaseUrl;

  Future<User?> signup(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/signup');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = data['user'];
        return User.fromJson(userData);
      } else {
        throw Exception("Failed to sign up. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error during signup: $e");
    }
  }

  Future<User?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = data['user'];
        final prefs = await SharedPreferences.getInstance();

        if (data['token'] != null) {
          await prefs.setString('token', data['token']);
        }

        return User.fromJson(userData);
      } else {
        throw Exception("Failed to log in. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error during login: $e");
    }
  }

  // ✅ Add this new function for profile fetching
  Future<User> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('User not logged in.');

    final response = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData['user']);
    } else {
      throw Exception('Failed to fetch profile: ${response.statusCode}');
    }
  }
}
