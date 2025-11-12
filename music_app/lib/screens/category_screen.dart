import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/service/song_service.dart';
import 'music_player_screen.dart';
import 'package:music_app/service/audio_manager.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final api = ApiService();
    final Future<List<Song>> categorySongs = api.searchSongs(category);

    return Container(
      // ✅ Same gradient as PageStruct / HomePage
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.0,
            0.15, // 15% gradient at top
            1.0   // 85% black
          ],
          colors: [
            Color(0xFF7A43BF), // top purple glow
            Color(0xFF512D80), // deep violet
            Color(0xFF000000), // black for most of the page
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF7A43BF), // ✅ same as gradient top
          title: Text(
            category,
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        body: FutureBuilder<List<Song>>(
          future: categorySongs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No songs found in this category",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }

            final songs = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final s = songs[index];
                return GestureDetector(
                  onTap: () {
                    AudioManager().playSong(s);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MusicPlayerScreen(song: s),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          s.image,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 55,
                            height: 55,
                            color: Colors.grey.shade800,
                            child: const Icon(
                              Icons.music_note,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        s.title,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        s.artist,
                        style:
                            const TextStyle(color: Colors.white70, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
