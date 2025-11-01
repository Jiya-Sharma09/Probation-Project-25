
class Song{

  String title;
  String artistName;
  String preview;
  String image;

  Song({
    required this.artistName,
    required this.image,
    required this.title,
    required this.preview
    });

  factory Song.fromJson(Map<String,dynamic> teddy){
    return Song(
    artistName: teddy['artist']['name'] ?? '', 
    image: teddy['album']['cover'] ?? '', 
    title: teddy['title'] ?? '', 
    preview: teddy['preview'] ?? ''
    );
  }

}