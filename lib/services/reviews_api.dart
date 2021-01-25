import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movify/constatnts/constatnt.dart';
import 'package:movify/exceptions/http_exception.dart';
import 'package:movify/models/review.dart';

class ReviewsApi{

  Future<List<Review>> fetchReviews(int id) async {
    try {
      final url = "https://api.themoviedb.org/3/movie/$id/reviews?api_key=$API_KEY&language=en-US&page=1";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String source = response.body;
        if (source.isNotEmpty) {
          var jsonData = json.decode(source);
          ReviewsList reviewsList = ReviewsList.fromJson(jsonData);
          List<Review> loadedReviews = reviewsList.reviews.map((e) => Review.fromJson(e)).toList();
          return loadedReviews;
        }
      } else {
        print("Status Code: ${response.statusCode}");
      }
    } on FetchDataException catch (error) {
      print("error : $error");
    } catch (error) {
      print("error : $error");
    }
  }
}