import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/song_model.dart';
import 'package:music_app/service/api_config.dart';
import 'package:music_app/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      }
      return [];
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
      }
      return [];
    } catch (e) {
      throw Exception("Error searching songs: $e");
    }
  }

  // ✅ Fetch wishlist
  Future<List<Song>> getWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    try {
      final res = await http.get(
        Uri.parse("$baseUrl/api/wishlist"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data.map((e) => Song.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception("Error fetching wishlist: $e");
    }
  }
}
