
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movify/views/auth.dart';
import 'package:movify/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const route = 'splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeScreen.route);
      if(FirebaseAuth.instance.currentUser != null){
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      }else{
        Navigator.pushReplacementNamed(context, AuthScreen.route);
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff302b63),
                    Color(0xff0f0c29),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0.0,-90.0) ,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              left: MediaQuery.of(context).size.width /2,
              child: Container(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xff302b63),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
