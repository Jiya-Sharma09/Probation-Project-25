import 'dart:convert';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/service/api_config.dart';
import 'package:music_app/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = ApiConfig.activeBaseUrl;

  // ✅ Fetch all songs
  Future<List<Song>> fetchAllSongs() async {
    if (ApiConfig.useDummyData) return dummySongs;

    try {
      final res = await http.get(Uri.parse("$baseUrl/api/songs"));
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data.map((e) => Song.fromJson(e)).toList();
      } else {
        print("⚠️ fetchAllSongs failed: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching songs: $e");
    }
  }

  // ✅ Search songs
  Future<List<Song>> searchSongs(String query) async {
    if (ApiConfig.useDummyData) {
      return dummySongs
          .where((s) =>
              s.title.toLowerCase().contains(query.toLowerCase()) ||
              s.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    try {
      final res = await http.get(Uri.parse("$baseUrl/api/songs?search=$query"));
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data.map((e) => Song.fromJson(e)).toList();
      } else {
        print("⚠️ searchSongs failed: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      throw Exception("Error searching songs: $e");
    }
  }

  // ✅ Fetch wishlist
  Future<List<Song>> getWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) return [];

    try {
      final res = await http.get(
        Uri.parse("$baseUrl/api/wishlist"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data.map((e) => Song.fromJson(e)).toList();
      } else {
        print("⚠️ getWishlist failed: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching wishlist: $e");
    }
  }

  // ✅ Remove song from wishlist
  Future<bool> removeFromWishlist(String songId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) return false;

    try {
      final res = await http.delete(
        Uri.parse("$baseUrl/api/wishlist/remove/$songId"),
        headers: {"Authorization": "Bearer $token"},
      );
      return res.statusCode == 200;
    } catch (e) {
      print("❌ Error removing song: $e");
      return false;
    }
  }
}
