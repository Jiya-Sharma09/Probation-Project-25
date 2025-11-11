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
  late Future<List<Song>> taylorSongs;
  late Future<List<Song>> arijitSongs;
  late Future<List<Song>> sabrinaSongs;
  late Future<List<Song>> lofiSongs;
  late Future<List<Song>> loveSongs;

  final TextEditingController searchController = TextEditingController();
  Future<List<Song>>? searchResults;

  @override
  void initState() {
    super.initState();

    final api = ApiService();

    allSongs = api.fetchAllSongs();
    taylorSongs = api.searchSongs("taylor swift");
    arijitSongs = api.searchSongs("arijit singh");
    sabrinaSongs = api.searchSongs("sabrina carpenter");
    lofiSongs = api.searchSongs("lofi");
    loveSongs = api.searchSongs("love");
  }

  void _onSearchChanged(String value) {
    if (value.trim().isEmpty) {
      setState(() => searchResults = null);
      return;
    }
    setState(() {
      searchResults = ApiService().searchSongs(value);
    });
  }

  Widget songScroller(Future<List<Song>> future) {
    return SizedBox(
      height: 190,
      child: FutureBuilder<List<Song>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No songs found", style: TextStyle(color: Colors.white)),
            );
          }

          final songs = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final s = songs[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MusicPlayerScreen(song: s),
                    ),
                  );
                },
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
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
            },
          );
        },
      ),
    );
  }

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
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.12),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),

          if (searchResults != null) ...[
            sectionTitle("Search Results"),
            songScroller(searchResults!),
            const SizedBox(height: 20),
          ],

          sectionTitle("All Songs"),
          songScroller(allSongs),

          sectionTitle("Taylor Swift"),
          songScroller(taylorSongs),

          sectionTitle("Arijit Singh"),
          songScroller(arijitSongs),

          sectionTitle("Sabrina Carpenter"),
          songScroller(sabrinaSongs),

          sectionTitle("Love"),
          songScroller(loveSongs),

          sectionTitle("Lofi"),
          songScroller(lofiSongs),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
