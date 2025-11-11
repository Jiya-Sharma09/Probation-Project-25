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

  final _pageList = [homeScreen(),  UserLibraryScreen(), ProfilePage()];

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color.fromARGB(224, 54, 52, 52),
      appBar: MainAppBar(title: 'Muziko', onSettingsTap: () {
      // Navigate anywhere
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    },),

      body: _pageList[selectedIndex],
      

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(81, 66, 65, 65),

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
