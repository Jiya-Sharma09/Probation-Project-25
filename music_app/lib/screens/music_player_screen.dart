import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/service/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _player;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  Future<void> addToWishlist() async {
    final songId = widget.song.id;
    final url = "${ApiConfig.activeBaseUrl}/wishlist/add/$songId";

    // Read JWT token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("authToken");

    if (token == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please log in first")));
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Added to liked songs")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed: ${response.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      // ✅ NEW: Build complete audio URL
      final audioUrl = "${ApiConfig.activeBaseUrl}${widget.song.url}";

      await _player.setUrl(audioUrl);

      _player.durationStream.listen((d) {
        if (d != null) setState(() => _duration = d);
      });

      _player.positionStream.listen((p) {
        setState(() => _position = p);
      });
    } catch (e) {
      print("Audio load error: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String formatTime(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inMinutes)}:${two(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.song;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(song.title, style: TextStyle(color: Color(0xFF512D80))),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFF512D80)),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Color(0xFF512D80)),
            onPressed: addToWishlist,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                song.image,
                height: 260,
                width: 260,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              song.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            Text(
              song.artist,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds
                  .clamp(0, _duration.inSeconds)
                  .toDouble(),
              activeColor: Color(0xFF512D80),
              inactiveColor: Colors.grey,
              onChanged: (value) {
                _player.seek(Duration(seconds: value.toInt()));
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(_position),
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  formatTime(_duration),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 30),

            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final isPlaying = snapshot.data?.playing ?? false;

                return IconButton(
                  iconSize: 60,
                  color: Color(0xFF512D80),
                  icon: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                  ),
                  onPressed: () {
                    isPlaying ? _player.pause() : _player.play();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
