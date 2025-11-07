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

  final _pageList = [homeScreen(),  UserLibrary(), ProfilePage()];

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(129, 12, 0, 0),
      ),

      body: _pageList[selectedIndex],
      

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 42, 41, 41),

        selectedItemColor: Color(0xFF512D80),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),

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
