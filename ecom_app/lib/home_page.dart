import 'package:flutter/material.dart';
import 'package:standard_searchbar/new/standard_search_anchor.dart';
import 'package:standard_searchbar/new/standard_search_bar.dart';
import 'package:standard_searchbar/new/standard_suggestions.dart';
import 'package:standard_searchbar/new/standard_suggestion.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: Column(
        children: [
          // implementing search bar : 
          const SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 10),
                SizedBox(
                  width: 360,
                  child: StandardSearchAnchor(
                    searchBar: StandardSearchBar(
                      bgColor: Color.fromARGB(255, 244, 178, 200)
                    ),
                    suggestions: StandardSuggestions(
                      suggestions: [
                        StandardSuggestion(text: "bags"),
                        StandardSuggestion(text: "tops"),
                        StandardSuggestion(text: "heels"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child : Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child : CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 240, 171, 202),
              
                child: Text('Women', style: TextStyle(fontSize: 10),),
              ),),

              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 240, 171, 202),
                child: Text('men', style: TextStyle(fontSize: 10),),
              ),),

              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 240, 171, 202),
                child: Text('kids', style: TextStyle(fontSize: 10),),
              ),),

              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 240, 171, 202),
                child: Text('skincare', style: TextStyle(fontSize: 10),),
              ),),

              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 240, 171, 202),
                child: Text('home', style: TextStyle(fontSize: 10),),
              ),),

              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 240, 171, 202),
                child: Text('health', style: TextStyle(fontSize: 10),),
              ),),

              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 240, 171, 202),
                child: Text('stationary', style: TextStyle(fontSize: 10),),
              ),),
            ],
          ),
          ),
          ),

          // carousel slider :
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
            ),
            items:
                [
                  "assets/images/bags.jpg",
                  "assets/images/jewellery.jpg",
                  "assets/images/download.jpg",
                ].map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(imagePath, fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                }).toList(),
          ),

        // list of products

        Column(
          children:[ 
          Container(
            height: 300,
            width: 350,
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child : Image.asset('assets/images/p1.png'),)
              ],
            ),
          ),

           Container(
            height: 300,
            width: 350,
            margin: EdgeInsets.all(10),
            child: Image.asset('assets/images/p2.png'),
          ),

        Container(
            height: 300,
            width: 350,
            margin: EdgeInsets.all(10),
            child: Image.asset('assets/images/p3.png'),
          ),

          Container(
            height: 300,
            width: 350,
            margin: EdgeInsets.all(10),
            child: Image.asset('assets/images/p4.png'),
          ),

          ]

        )

        ],      
          
  )
        
   ); 

  }    
    
  
}
