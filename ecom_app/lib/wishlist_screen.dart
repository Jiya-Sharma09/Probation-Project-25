import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children:[ 

          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(10),
            color: Color.fromARGB(255, 228, 78, 128),
            child : Center(
              child :  Text("Wishlist", style: TextStyle(fontWeight: FontWeight.bold)),
              
              ),
          ),

          SizedBox(
            height: 200,
            child: Image.asset('assets/images/wishlist1.png'),
          ),

          SizedBox(
            height: 200,
            child: Image.asset('assets/images/wishlist2.png'),
          ),

          SizedBox(
            height: 200,
            child: Image.asset('assets/images/wishlist3.png'),
          ),


          ],

        )
        );
  }
}
