class Song {
  final String id;
  final String title;
  final String artist;
  final String image;
  final String url; // audio URL (mp3)

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.url,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      image: json['image'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
