import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movify/utils/local_notifications.dart';
import 'package:movify/view_models/categories_list_view_model.dart';
import 'package:movify/view_models/movies_list_view_model.dart';
import 'package:movify/view_models/review_view_model.dart';
import 'package:movify/views/auth.dart';
import 'package:movify/views/home_view.dart';
import 'package:movify/views/movie_details_view.dart';
import 'package:movify/views/search_results_view.dart';
import 'package:movify/views/splash_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoviesListViewModel>(
          create: (context) => MoviesListViewModel(),
        ),
        ChangeNotifierProvider<CategoriesListViewModel>(
          create: (context) => CategoriesListViewModel(),
        ),
        ChangeNotifierProvider<ReviewsViewModel>(
          create: (context) => ReviewsViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Movify',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          SplashScreen.route: (context) => SplashScreen(),
          AuthScreen.route: (context) => AuthScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          MovieDetails.route: (context) => MovieDetails(),
          SearchResultsScreen.route: (context) => SearchResultsScreen(),
        },
      ),
    );
  }
}
