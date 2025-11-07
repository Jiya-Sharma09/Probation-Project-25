import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/song_model.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _player;    // just_audio player
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      await _player.setUrl(widget.song.preview);

      // Listen to duration + position updates
      _player.durationStream.listen((d) {
        if (d != null) {
          setState(() => _duration = d);
        }
      });

      _player.positionStream.listen((p) {
        setState(() => _position = p);
      });
    } catch (e) {
      print("Error loading audio: $e");
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
        title: Text(song.title, style: TextStyle(color: Color(0xFFAE871A))),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFAE871A)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Song Image
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

            // Title
            Text(
              song.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            // Artist
            Text(
              song.artistName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // Slider
            Slider(
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.clamp(0, _duration.inSeconds).toDouble(),
              activeColor: Color(0xFFAE871A),
              inactiveColor: Colors.grey,
              onChanged: (value) {
                _player.seek(Duration(seconds: value.toInt()));
              },
            ),

            // Time Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(_position), style: TextStyle(color: Colors.grey)),
                Text(formatTime(_duration), style: TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 30),

            // Play / Pause
            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final isPlaying = playerState?.playing ?? false;

                return IconButton(
                  iconSize: 60,
                  color: Color(0xFFAE871A),
                  icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
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
