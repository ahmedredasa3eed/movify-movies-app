import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 10,),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home,),
              title: Text("Home", style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,),),
            ),
            ListTile(
              leading: Icon(Icons.account_box,),
              title: Text("Profile", style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,),),
            ),
            ListTile(
              leading: Icon(Icons.settings,),
              title: Text("Settings", style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,),),
            ),
            ListTile(
              onTap: (){
                FirebaseAuth.instance.signOut();
              },
              leading: Icon(Icons.login,),
              title: Text("Logout", style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,),),
            ),
          ],
        ),
      ),
    );
  }
}
