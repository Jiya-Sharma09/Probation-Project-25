import 'package:music_app/service/api_config.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String image;
  final String url;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.url,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    final base = ApiConfig.activeBaseUrl;

    return Song(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',

      image: json['imagePath'] != null
          ? "$base${json['imagePath']}"
          : "https://via.placeholder.com/200",

      // backend sends audioPath or url
      url: json['audioUrl'] != null
          ? "$base${json['audioUrl']}"
          : "",
    );
  }
}
