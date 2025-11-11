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

  bool isLiked = false; // ✅ used to toggle filled heart

  Future<void> addToWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please log in first")));
      return;
    }

    final url =
        "${ApiConfig.activeBaseUrl}/api/wishlist/add/${widget.song.id}";

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode == 200) {
        setState(() => isLiked = true); // ✅ fill heart
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Added to liked songs")),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed: ${res.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _player.setUrl(widget.song.url.trim());
      _player.play();

      _player.durationStream.listen((d) {
        if (d != null) setState(() => _duration = d);
      });

      _player.positionStream.listen((p) {
        setState(() => _position = p);
      });
    } catch (e) {
      print("Audio Error: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String formatTime(Duration d) {
    return "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ✅ Same Spotify-like gradient as PageStruct
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.35, 0.55, 1.0],
          colors: [
            Color(0xFF7A43BF),   // soft purple glow (same as PageStruct top)
            Color(0xFF512D80),   // signature violet
            Color(0xFF2A1B45),   // deeper near-black purple
            Color(0xFF000000),   // full black bottom
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: const Color(0xFF7A43BF), // ✅ same top color
          elevation: 0,
          title: Text(
            widget.song.title,
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),

          actions: [
            IconButton(
              onPressed: addToWishlist,
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Color(0xFF2A1B45) : Colors.white, // ✅ change color
              ),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ glowing album art
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFA259FF).withOpacity(0.45),
                      blurRadius: 50,
                      spreadRadius: 5,
                      offset: const Offset(0, 25),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.network(
                    widget.song.image,
                    height: 260,
                    width: 260,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                widget.song.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                widget.song.artist,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 35),

              Slider(
                min: 0,
                max: _duration.inSeconds.toDouble(),
                value: _position.inSeconds.clamp(
                  0,
                  _duration.inSeconds,
                ).toDouble(),
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                onChanged: (value) =>
                    _player.seek(Duration(seconds: value.toInt())),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(_position),
                      style: const TextStyle(color: Colors.white70)),
                  Text(formatTime(_duration),
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),

              const SizedBox(height: 40),

              StreamBuilder<PlayerState>(
                stream: _player.playerStateStream,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data?.playing ?? false;

                  return IconButton(
                    iconSize: 72,
                    color: Colors.white,
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
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
      ),
    );
  }
}
