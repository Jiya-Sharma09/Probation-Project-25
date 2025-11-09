import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/service/song_service.dart';
import 'music_player_screen.dart';

class UserLibraryScreen extends StatefulWidget {
  const UserLibraryScreen({super.key});

  @override
  State<UserLibraryScreen> createState() => _UserLibraryScreenState();
}

class _UserLibraryScreenState extends State<UserLibraryScreen> {
  late Future<List<Song>> wishlistFuture;

  @override
  void initState() {
    super.initState();
    wishlistFuture = ApiService().getWishlist();
  }

  // ✅ Same tile design as home screen
  Widget songTile(Song s) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MusicPlayerScreen(song: s),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                s.image,
                height: 100,
                width: 140,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  width: 140,
                  color: Colors.white,
                  child: const Icon(Icons.music_note),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              s.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              s.artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Song>>(
        future: wishlistFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No liked songs yet",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            );
          }

          final songs = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    "Your Liked Songs",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF512D80),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    children: songs.map((s) => songTile(s)).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
