import 'package:flutter/material.dart';
import 'package:music_app/service/audio_manager.dart';
import 'package:music_app/screens/music_player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final audioManager = AudioManager();

    return AnimatedBuilder(
      animation: audioManager,
      builder: (context, _) {
        final song = audioManager.currentSong;
        if (song == null) return const SizedBox.shrink();

        return Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MusicPlayerScreen(song: song),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 65,
              width: MediaQuery.of(context).size.width * 0.88, // reduced width
              decoration: BoxDecoration(
                color: Color(0xFF512D80), // ✅ Solid black background
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Album art
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      song.image,
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 45,
                        height: 45,
                        color: Colors.grey.shade800,
                        child: const Icon(Icons.music_note, color: Colors.white70),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Song info
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          song.artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Play / Pause
                  IconButton(
                    icon: Icon(
                      audioManager.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: audioManager.togglePlayPause,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
