import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  }


class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
       SingleChildScrollView(
        child: Column(
          children: [



          ],
        ),
      ),
    )
      ,);
  
}}