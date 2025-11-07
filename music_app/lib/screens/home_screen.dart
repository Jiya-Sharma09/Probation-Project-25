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
  // Cache futures here so they are created once
  late Future<List<Song>> topGlobalSongs;
  late Future<List<Song>> topIndianSongs;
  final Map<String, Future<List<Song>>> categoryFutures = {};

  // function for navigating to different screens  : 
  void NavigateScreen(){
    
  }

  @override
  void initState() {
    super.initState();

    // create futures once
    topGlobalSongs = ApiService().fetchTopGlobalSong();
    topIndianSongs = ApiService().fetchTopIndianSong();

    // example categories (cached by key)
    categoryFutures['arijit'] = ApiService().fetchSong('arijit singh');
    categoryFutures['sabrina'] = ApiService().fetchSong('sabrina carpenter');
    categoryFutures['taylor'] = ApiService().fetchSong('taylor swift');
    categoryFutures['ed'] = ApiService().fetchSong('ed sheeran');
    categoryFutures['love'] = ApiService().fetchSong('love');
    categoryFutures['lofi'] = ApiService().fetchSong('lofi');
  }

  // helper returns a widget for a horizontal list
  Widget displaySongs(Future<List<Song>> future) {
    return SizedBox(
      height: 190, // give a fixed height for horizontal list
      child: FutureBuilder<List<Song>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 245, 245, 247),));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No songs found.', style: TextStyle(color: Color.fromARGB(180, 245, 242, 242)),));
          }

          final songs = snapshot.data!;

          return ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: songs.length,
  itemBuilder: (context, index) {
    final song = songs[index]; // ✅ Instance, not class

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicPlayerScreen(song: song),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  color: const Color.fromARGB(255, 255, 252, 252),
                  child: const Icon(Icons.music_note),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              song.title,               
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              song.artistName,          
              style: const TextStyle(
                color: Color.fromARGB(255, 254, 253, 253),
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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

  // Example: refresh one category manually
  Future<void> refreshCategory(String key) async {
    setState(() {
      categoryFutures[key] = ApiService().fetchSong(
        key,
      ); // reassign Future to re-fetch
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Top Global songs',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF512D80),
                  ),
                ),
              ),
            ),
            displaySongs(topGlobalSongs),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Top Indian songs',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF512D80),
                  ),
                ),
              ),
            ),
            displaySongs(topIndianSongs),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Songs by Artist : ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF512D80),
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Arijit Singh',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 247, 247, 246),
                  ),
                ),
              ),
            ),
            displaySongs(categoryFutures['arijit']!),


            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Ed sheeren',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 247, 247, 246),
                  ),
                ),
              ),
            ),
            displaySongs(categoryFutures['ed']!),


            // ... other categories
            const SizedBox(height: 20),
          ],
        ));
  }
}
