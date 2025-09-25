import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart.dart';
import 'wishlist_screen.dart';
import 'profile.dart';

class PageStruct extends StatefulWidget {
  const PageStruct({super.key});

  @override
  State<PageStruct> createState() => _PageState();
}

class _PageState extends State<PageStruct> {

  int selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CategoriesPage(),
    CartPage(),
    ProfilePage(),
  ];

  
          void _onItemTapped(int index) {
            setState(() {
            selectedIndex = index;
              });
            }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopaholics"),),

      body: _pages[selectedIndex],

      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // keeps all icons visible
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(
          255,
          245,
          95,
          153,
        ), // highlight color for selected tab
        unselectedItemColor: Color.fromARGB(
          255,
          241,
          180,
          190,
        ), // color for inactive tabs
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "wishlist/saved",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

      // backgroundColor: Colors.black12,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),


    );
  }
}