import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movify/constatnts/constatnt.dart';
import 'package:movify/exceptions/http_exception.dart';
import 'package:movify/models/movie.dart';


class MovieApi {

  Future<List<Movie>> fetchMovies(String segment) async {
    try {
      final url = "https://api.themoviedb.org/3/movie/$segment?api_key=$API_KEY&language=en-US&page=1";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String source = response.body;
        if (source.isNotEmpty) {
          var jsonData = json.decode(source);
          MoviesList moviesList = MoviesList.fromJson(jsonData);
          List<Movie> loadedMovies =
              moviesList.movies.map((e) => Movie.fromJson(e)).toList();
          return loadedMovies;
        }
      } else {
        print("Status Code: ${response.statusCode}");
      }
    } on FetchDataException catch (error) {
      print("error 1 $error");
    } catch (error) {
      print("error 2 $error");
    }
  }

  Future<List<Movie>> searchForMovie(String query) async {
    try {
      final url = "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$query&language=en-US&page=1&include_adult=true";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String source = response.body;
        if (source.isNotEmpty) {
          var jsonData = json.decode(source);
          MoviesList moviesList = MoviesList.fromJson(jsonData);
          List<Movie> loadedMovies =
          moviesList.movies.map((e) => Movie.fromJson(e)).toList();
          return loadedMovies;
        }
      } else {
        print("Status Code: ${response.statusCode}");
      }
    } on FetchDataException catch (error) {
      print("error 1 $error");
    } catch (error) {
      print("error 2 $error");
    }
  }
}
