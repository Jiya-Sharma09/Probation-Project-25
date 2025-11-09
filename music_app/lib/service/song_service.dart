import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/song_model.dart';
import 'package:music_app/service/api_config.dart';
import 'package:music_app/dummy_data.dart';



class ApiService {
  final baseUrl = ApiConfig.activeBaseUrl;  
  // example: https://loginsignup-2.onrender.com

  // ✅ Fetch ALL songs
  Future<List<Song>> fetchAllSongs() async {
    // ✅ Use dummy data if toggle is enabled
    if (ApiConfig.useDummyData) {
      return dummySongs;
    }

    try {
      final response = await http.get(Uri.parse('$baseUrl/api/songs'));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((json) => Song.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error fetching songs: $e");
    }
  }

  // ✅ SEARCH songs by query
  Future<List<Song>> searchSongs(String query) async {
    if (ApiConfig.useDummyData) {
      // filter dummy songs
      return dummySongs
          .where((song) =>
              song.title.toLowerCase().contains(query.toLowerCase()) ||
              song.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/songs?search=$query'),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((json) => Song.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error searching songs: $e");
    }
  }
}
