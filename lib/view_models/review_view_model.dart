import 'package:flutter/cupertino.dart';
import 'package:movify/models/review.dart';
import 'package:movify/services/reviews_api.dart';

class ReviewsViewModel with ChangeNotifier {

  List<Review> _reviewsList = [];
  List<Review> get reviewsList => _reviewsList;

  Future<List<Review>> fetchAllReviews(int id) async {
    return _reviewsList = await ReviewsApi().fetchReviews(id);
  }

}