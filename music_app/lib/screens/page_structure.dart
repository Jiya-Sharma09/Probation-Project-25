import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile.dart';
import 'user_library.dart';
import 'main_app_bar.dart';
import 'settings_screen.dart';
import 'package:music_app/widgets/mini_player.dart';

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
      // ✅ Gradient: 15% purple → 85% black 
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.0,
            0.15, // only 15% gradient
            1.0   // rest fully black
          ],
          colors: [
            Color(0xFF7A43BF), // subtle glow at very top
            Color(0xFF512D80), // dark violet fade
            Color(0xFF000000), // BLACK for 85% of screen
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        // ✅ App bar color = same as top of gradient
        appBar: const MainAppBar(
          title: 'Muziko',
          onSettingsTap: null,
          color: Color(0xFF7A43BF), // blends perfectly
        ),

        body: Stack(
          children: [
            Positioned.fill(child: _pageList[selectedIndex]),

            // ✅ Mini Player above bottom nav
            const Positioned(
              left: 0,
              right: 0,
              bottom: 65,
              child: MiniPlayer(),
            ),
          ],
        ),

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.black),
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
