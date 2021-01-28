import 'package:flutter/cupertino.dart';
import 'package:movify/models/categories.dart';
import 'package:movify/services/categories_api.dart';

class CategoriesListViewModel with ChangeNotifier{

  List<Category> _categoriesList = [];

  List<Category> get categoriesList => _categoriesList;

  Future<List<Category>> fetchAllCategories() async {

    return _categoriesList = await CategoriesApi().fetchCategories();
  }
}