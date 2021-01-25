import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movify/constatnts/constatnt.dart';
import 'package:movify/exceptions/http_exception.dart';
import 'package:movify/models/categories.dart';

class CategoriesApi {

  Future<List<Category>> fetchCategories() async {
    try {
      final url = "https://api.themoviedb.org/3/genre/movie/list?api_key=$API_KEY&language=en-US&page=1";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String source = response.body;
        if (source.isNotEmpty) {
          var jsonData = json.decode(source);
          CategoryList categoryList = CategoryList.fromJson(jsonData);
          List<Category> loadedCategories =
              categoryList.categories.map((e) => Category.fromJson(e)).toList();
          return loadedCategories;
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
