import 'package:flutter/material.dart';
import 'home_screen.dart';

class PageStruct extends StatefulWidget {
  const PageStruct({super.key});

  @override
  State<PageStruct> createState() => _PageState();
}

class _PageState extends State<PageStruct> {

  int selectedIndex = 0;

  final List<Widget> _pages = [
    homeScreen(),
  ];

  
          void _onItemTapped(int index) {
            setState(() {
            selectedIndex = index;
              });
            }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),

        title: Text('Geet', style: TextStyle(fontSize: 20)),

        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],

        iconTheme: IconThemeData(color: Color.fromARGB(255, 238, 195, 64)),
      ),

      body: _pages[selectedIndex],

      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // keeps all icons visible
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color.fromARGB(255, 144, 109, 2), // highlight color for selected tab
        unselectedItemColor:  Color.fromARGB(255, 238, 195, 64), // color for inactive tabs
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Library",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

      // backgroundColor: Colors.black12,
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),


    );
  }
}