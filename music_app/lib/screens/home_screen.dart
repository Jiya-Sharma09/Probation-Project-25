import 'package:flutter/material.dart';
//import 'package:just_audio/just_audio.dart';

import 'package:music_app/service/song_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:searchfield/searchfield.dart';

class homeScreen extends StatelessWidget {
  Future<List<dynamic>>? songList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),

        title: Text('Geet', style: TextStyle(fontSize: 20)),

        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],

        iconTheme: IconThemeData(color: Color.fromARGB(255, 238, 195, 64)),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // search bar (package from pub.dev): 
            Padding(padding: EdgeInsetsGeometry.all(18)
              child: SearchField(suggestions: suggestions),
            )

            // for top global charts :

            FutureBuilder(
              future: ApiService().fetchTopGlobalSong(),
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
                      subtitle: Text(song.artist),
                    );
                  },
                );
              },
            ),

            // for top indian songs : 

            FutureBuilder(
              future: ApiService().fetchTopIndianSong(),
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
                      subtitle: Text(song.artist),
                    );
                  },
                );
              },
            ),

            // categorisation : artists (5) ***

            // arijit singh :

            FutureBuilder(
              future: ApiService().fetchSong('arijit singh'),
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
                      subtitle: Text(song.artist),
                    );
                  },
                );
              },
            ),

            // sabrina carpenter : 

            FutureBuilder(
              future: ApiService().fetchSong('sabrina carpenter'),
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
                      subtitle: Text(song.artist),
                    );
                  },
                );
              },
            ),

            // taylor swift : 

            FutureBuilder(
              future: ApiService().fetchSong('taylor swift'),
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
                      subtitle: Text(song.artist),
                    );
                  },
                );
              },
            ),

          // ed sheeren 

          FutureBuilder(
              future: ApiService().fetchSong('ed sheeren'),
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
                      subtitle: Text(song.artist),
                    );
                  },
                );
              },
            ),

            // 


            // categorisation : genres  (love, lofi, )

            FutureBuilder(
              future: ApiService().fetchSong('love'),
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
                      subtitle: Text(song.artist),
                    );
                  },
                );
              },
            ),

            // songs by category : lofi songs

          FutureBuilder(
              future: ApiService().fetchSong('love'),
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
                      subtitle: Text(song.artist),
                    );
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
