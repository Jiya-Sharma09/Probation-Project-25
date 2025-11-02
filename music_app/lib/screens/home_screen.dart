import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';
//import 'package:just_audio/just_audio.dart';

import 'package:music_app/service/song_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:searchfield/searchfield.dart';

class homeScreen extends StatelessWidget {
  Future<List<dynamic>>? songList;

  // making fetching songs for diff generes easier

  displaySongs(future) {
    FutureBuilder<List<Song>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No songs found.'));
        }

        final songs = snapshot.data!;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return ListTile(
              leading: Image.network(song.image),
              title: Text(song.title),
              subtitle: Text(song.artistName),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // search bar (package from pub.dev):
          Padding(
            padding: EdgeInsetsGeometry.all(18),
            child: SearchField(
              suggestions: [
                // ML *****

                // examples by app developer :
                SearchFieldListItem('tears'),
                SearchFieldListItem('hallucinate'),
              ],
            ),
          ),

          // for top global charts :
          SizedBox(height: 10),

          Container(height: 20, child: Text('Top Global songs')),

          displaySongs(ApiService().fetchTopGlobalSong()),

          // for top indian songs :
          SizedBox(height: 10),

          Container(height: 20, child: Text('Top Indian songs')),

          SizedBox(height: 5),

          displaySongs(ApiService().fetchTopIndianSong()),

          // categorisation : artists (5) ***
          SizedBox(height: 10),

          Container(height: 30, child: Text('Song by artist : ')),

          SizedBox(height: 10),

          // arijit singh :
          SizedBox(height: 10),

          Container(height: 20, child: Text('arijit singh')),

          SizedBox(height: 5),

          displaySongs(ApiService().fetchSong('arijit singh')),

          // sabrina carpenter :
          SizedBox(height: 10),

          Container(height: 20, child: Text('sabrina carpenter')),

          SizedBox(height: 5),

          displaySongs(ApiService().fetchSong('sabrina carpenter')),

          // taylor swift :
          SizedBox(height: 10),

          Container(height: 20, child: Text('taylor swift')),
          SizedBox(height: 5),

          displaySongs(ApiService().fetchSong('taylor swift')),

          // ed sheeren
          SizedBox(height: 10),

          Container(height: 20, child: Text('ed sheeren')),

          SizedBox(height: 5),

          displaySongs(ApiService().fetchSong('ed sheeren')),
          //

          // categorisation : genres  (love, lofi, )
          SizedBox(height: 10),

          Container(height: 20, child: Text('love')),

          SizedBox(height: 5),

          displaySongs(ApiService().fetchSong('love')),

          // songs by category : lofi songs
          SizedBox(height: 10),

          Container(height: 20, child: Text('lofi')),
          SizedBox(height: 5),

          displaySongs(ApiService().fetchSong('lofi')),
        ],
      ),
    );
  }
}
