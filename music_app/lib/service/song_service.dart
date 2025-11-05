import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/models/song_model.dart';
import 'api_config.dart';

class ApiService {
  final baseUrl = ApiConfig.activeBaseUrl;
  // all the following functions are written in accordance with a base url that i will later change in the main api_config.dart file

  // to fetch songs form the external open database uisng api key
  // api service mein pehele we need an api we use convert

  Future<List<Song>> fetchSong(String querry) async {
    // when i get url from the exernal url for fetching the songs enter it here :

    try {
      final response = await http.get(Uri.parse('$baseUrl/search?q=$querry'));

      if (response.statusCode == 200) {
        // response body : response.body will contain a list of maps each individual map contains a song
        final data = jsonDecode(response.body)['data'];

        return List<Song>.from(data.map((song) => Song.fromJson(song)));

      } else {
        return [];
      }
    } catch (e) {
      throw Exception("couldn't load songs !");
    }
  }

  // now for fetchng top global songs for homescreen

  Future<List<Song>> fetchTopGlobalSong() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/chart/0/tracks'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return List<Song>.from(data.map((song) => Song.fromJson(song)));

      } else {
        return [];
      }
    } catch (e) {
      throw Exception("an unexpected error occured !");
    }
  }

  // now for fetching top indian songs

  Future<List<Song>> fetchTopIndianSong() async {
    // when i get url from the exernal url for fetching the songs enter it here :

    try {
      final response = await http.get(Uri.parse('$baseUrl/chart/IN/tracks'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return List<Song>.from(data.map((song) => Song.fromJson(song)));

      } else {
        return [];
      }
    } catch (e) {
      throw Exception("an unexpected error occured !");
    }
  }
}
