import 'package:flutter/material.dart';
import 'package:movify/models/movie.dart';
import 'package:movify/services/movies_api.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  fetchMovies() async{
    List<Movie> movies = await MovieApi().fetchMovies("popular");
    for(var movie in movies){
      print(movie.originalTitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
