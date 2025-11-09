import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/service/song_service.dart';
import 'music_player_screen.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late Future<List<Song>> allSongs;
  late Future<List<Song>> topGlobal;
  late Future<List<Song>> topIndian;
  late Future<List<Song>> arijitSongs;
  late Future<List<Song>> taylorSongs;
  late Future<List<Song>> duaSongs;
  late Future<List<Song>> loveSongs;
  late Future<List<Song>> lofiSongs;

  @override
  void initState() {
    super.initState();

    final api = ApiService();

    // ALL SONGS (full list)
    allSongs = api.fetchAllSongs();

    // CATEGORY FETCHES (dummy or real - ApiService handles switching)
    topGlobal = api.fetchAllSongs();       // later change to /top-global
    topIndian = api.fetchAllSongs();       // later change to /top-india

    arijitSongs = api.searchSongs("arijit");
    taylorSongs = api.searchSongs("taylor swift");
    duaSongs = api.searchSongs("dua lipa");
    loveSongs = api.searchSongs("love");
    lofiSongs = api.searchSongs("lofi");
  }

  // Horizontal Songs List
  Widget displaySongs(Future<List<Song>> future) {
    return SizedBox(
      height: 190,
      child: FutureBuilder<List<Song>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(200, 255, 255, 255),
              ),
            );
          }

          List<Song> songs = snapshot.data ?? [];

          if (songs.isEmpty) {
            return const Center(
              child: Text("No songs found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MusicPlayerScreen(song: song),
                    ),
                  );
                },
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          song.image,
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

                      // TITLE
                      Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),

                      // ARTIST
                      Text(
                        song.artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Style for section title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF512D80),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SEARCH BAR
          const Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          //Top Global
          sectionTitle("Top Global"),
          displaySongs(topGlobal),

          //Top Indian
          sectionTitle("Top Indian"),
          displaySongs(topIndian),

          // Arijit
          sectionTitle("Arijit Singh"),
          displaySongs(arijitSongs),

          // Taylor Swift
          sectionTitle("Taylor Swift"),
          displaySongs(taylorSongs),

          // Dua Lipa
          sectionTitle("Dua Lipa"),
          displaySongs(duaSongs),

          // Love Songs
          sectionTitle("Love"),
          displaySongs(loveSongs),

          // Lofi
          sectionTitle("Lofi"),
          displaySongs(lofiSongs),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
