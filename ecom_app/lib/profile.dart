import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        width: MediaQuery.of(context).size.width*0.8,
        child: Column(
          children: [
            Image.asset('assets/images/prof.jpg'),
            Text("User : Jiya Sharma", style: TextStyle(fontSize: 25),),
            Text("Phone number : 9520187841", style: TextStyle(fontSize: 18),),
            Text("Address : Agra", style: TextStyle(fontSize: 18),),
            // row : three buttons : orders, edit profile, logout
 
            Row(
              children: [
                      

              ],
            )

          ],
        ) ,
        ),
    );
  }
}
