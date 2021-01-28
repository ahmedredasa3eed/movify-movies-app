import 'package:flutter/cupertino.dart';
import 'package:movify/models/movie.dart';
import 'package:movify/services/movies_api.dart';

class MoviesListViewModel with ChangeNotifier{

  List<Movie> _moviesList = [];
  List<Movie> _moviesSearchResultList = [];

  List<Movie> get moviesList => _moviesList;
  List<Movie> get moviesSearchResultList => _moviesSearchResultList;

  Future<List<Movie>> fetchAllMovies(String segment) async{
    return _moviesList = await MovieApi().fetchMovies(segment);
  }

  Future<List<Movie>> getSearchResult(String query) async{
  return _moviesSearchResultList =  await MovieApi().searchForMovie(query);

  }
}