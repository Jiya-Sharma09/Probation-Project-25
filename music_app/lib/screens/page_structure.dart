import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile.dart';
import 'user_library.dart';

class PageStruct extends StatefulWidget {
  @override
  State<PageStruct> createState() => _PageStructState();
}

class _PageStructState extends State<PageStruct> {
  int selectedIndex = 0;

  final _pageList = [homeScreen(), ProfilePage(), UserLibrary()];

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: _pageList[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 42, 41, 41),

        selectedItemColor: Color.fromARGB(255, 174, 135, 26),
        unselectedItemColor: Color.fromARGB(255, 119, 89, 4),

        onTap: _onTap,

        currentIndex: selectedIndex,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_music_rounded),
            label: 'library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
