import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movify/utils/local_notifications.dart';
import 'package:movify/views/auth.dart';
import 'package:movify/views/home_screen.dart';
import 'package:movify/views/movie_details.dart';
import 'package:movify/views/search_results.dart';
import 'package:movify/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        SplashScreen.route : (context)=> SplashScreen(),
        AuthScreen.route : (context)=> AuthScreen(),
        HomeScreen.route : (context)=> HomeScreen(),
        MovieDetails.route : (context)=> MovieDetails(),
        SearchResultsScreen.route : (context)=> SearchResultsScreen(),
      },
    );
  }
}

