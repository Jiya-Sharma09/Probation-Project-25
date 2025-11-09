class Song {
  final String id;
  final String title;
  final String artist;
  final String image;   // full URL after combining base + imagePath
  final String url;     // audio URL

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.url,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    // Build full image URL
    final base = "https://loginsignup-2.onrender.com";

    return Song(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      
      // Build image path correctly
      image: json['imagePath'] != null
          ? base + json['imagePath']
          : "https://via.placeholder.com/200",

      // Audio URL
      url: json['audioUrl'] ?? '',
    );
  }
}
