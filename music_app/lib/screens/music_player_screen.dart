import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';
import '../service/audio_manager.dart';
import '../service/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;
  const MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool liked = false;

  late final AudioPlayer _player;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<Duration>? _positionSub;

  @override
  void initState() {
    super.initState();
    final manager = AudioManager();
    _player = manager.player;
    manager.playSong(widget.song);

    // ✅ Listen to duration and position safely
    _durationSub = _player.durationStream.listen((d) {
      if (!mounted) return;
      if (d != null) setState(() => _duration = d);
    });

    _positionSub = _player.positionStream.listen((p) {
      if (!mounted) return;
      setState(() => _position = p);
    });
  }

  @override
  void dispose() {
    // ✅ Cancel listeners so no more setState() calls after dispose
    _durationSub?.cancel();
    _positionSub?.cancel();
    super.dispose();
  }

  // ✅ Wishlist toggle
  Future<void> addToWishlist() async {
    setState(() => liked = true);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in first")),
      );
      return;
    }

    final url = "${ApiConfig.activeBaseUrl}/api/wishlist/add/${widget.song.id}";

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            res.statusCode == 200 ? "Added to liked songs" : "Failed!",
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  String formatTime(Duration d) {
    return "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.song;
    final player = _player;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.37, 0.58, 1.0],
          colors: [
            Color(0xFFA259FF),
            Color(0xFF7A43BF),
            Color(0xFF512D80),
            Colors.black,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFA259FF),
          title: Text(song.title, style: const TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: Icon(
                liked ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: addToWishlist,
            )
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Album Art
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7A43BF).withOpacity(0.4),
                      blurRadius: 60,
                      spreadRadius: 10,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    song.image,
                    height: 260,
                    width: 260,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 260,
                      width: 260,
                      color: Colors.grey.shade800,
                      child: const Icon(Icons.music_note, color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                song.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                song.artist,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 30),

              // ✅ Progress Slider
              Slider(
                min: 0,
                max: _duration.inSeconds.toDouble(),
                value:
                    _position.inSeconds.clamp(0, _duration.inSeconds).toDouble(),
                activeColor: Colors.white,
                inactiveColor: Colors.white38,
                onChanged: (value) {
                  player.seek(Duration(seconds: value.toInt()));
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(_position),
                      style: const TextStyle(color: Colors.white60)),
                  Text(formatTime(_duration),
                      style: const TextStyle(color: Colors.white60)),
                ],
              ),

              const SizedBox(height: 36),

              // ✅ Play/Pause
              StreamBuilder<PlayerState>(
                stream: player.playerStateStream,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data?.playing ?? false;
                  return IconButton(
                    iconSize: 75,
                    color: Colors.white,
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                    ),
                    onPressed: AudioManager().togglePlayPause,
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
