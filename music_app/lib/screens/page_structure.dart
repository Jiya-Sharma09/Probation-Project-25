import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile.dart';
import 'user_library.dart';
import 'main_app_bar.dart';
import 'settings_screen.dart';

class PageStruct extends StatefulWidget {
  @override
  State<PageStruct> createState() => _PageStructState();
}

class _PageStructState extends State<PageStruct> {
  int selectedIndex = 0;

  final _pageList = [
    homeScreen(),
    UserLibraryScreen(),
    ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ✅ Spotify-style luxury gradient background
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.3, 1.0],
          colors: [
            Color(0xFF7A43BF), // top glow
            Color(0xFF512D80), // deep purple
            Color(0xFF000000), // black
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        // ✅ FIXED AppBar that blends perfectly
        appBar: MainAppBar(
          title: 'Muziko',
          onSettingsTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SettingsScreen()),
            );
          },
          color: const Color(0xFF7A43BF), // ✅ SAME AS top gradient color
        ),

        body: _pageList[selectedIndex],

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.black87,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Color(0xFFB388FF),
            unselectedItemColor: Colors.white70,
            onTap: _onTap,
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_music_rounded), label: 'library'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded), label: 'profile'),
            ],
          ),
        ),
      ),
    );
  }
}
