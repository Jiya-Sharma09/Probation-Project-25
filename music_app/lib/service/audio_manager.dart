import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';

class AudioManager extends ChangeNotifier {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal() {
    // Listen to player state for UI updates
    _player.playerStateStream.listen((state) {
      isPlaying = state.playing;
      notifyListeners();
    });
  }

  final AudioPlayer _player = AudioPlayer();
  Song? currentSong;
  bool isPlaying = false;

  AudioPlayer get player => _player;

  Future<void> playSong(Song song) async {
    try {
      currentSong = song;
      await _player.stop(); // ensure clean playback
      await Future.delayed(const Duration(milliseconds: 150)); // safety delay
      await _player.setUrl(song.url.trim());
      await _player.play();
      isPlaying = true;
      notifyListeners();
      print("🎵 Now playing: ${song.title}");
    } catch (e) {
      print("❌ AUDIO LOAD ERROR: $e");
    }
  }

  void togglePlayPause() {
    if (_player.playing) {
      _player.pause();
      isPlaying = false;
    } else {
      _player.play();
      isPlaying = true;
    }
    notifyListeners();
  }

  void disposePlayer() {
    _player.dispose();
  }
}
