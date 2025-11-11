class Song {
  final String id;
  final String title;
  final String artist;
  final String image;   // FULL image URL
  final String url;     // FULL audio URL

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.url,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    const String base = "https://loginsignup-2.onrender.com";

    // ✅ FIX IMAGE URL
    String imagePath = json["imagePath"] ?? "";
    if (imagePath.startsWith("http")) {
      // Already full Cloudinary URL
    } else {
      imagePath = "$base$imagePath";
    }

    // ✅ FIX AUDIO URL
    String audioUrl = json["audioUrl"] ?? "";
    if (audioUrl.startsWith("http")) {
      // Already full URL
    } else {
      audioUrl = "$base$audioUrl";
    }

    return Song(
      id: json["id"]?.toString() ?? "",
      title: json["title"] ?? "",
      artist: json["artist"] ?? "",
      image: imagePath,
      url: audioUrl,
    );
  }
}
