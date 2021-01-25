class Category {
  int id;
  String name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    return Category(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}

class CategoryList {
  List<dynamic> categories;

  CategoryList({this.categories});

  factory CategoryList.fromJson(Map<String, dynamic> jsonData) {
    return CategoryList(
      categories: jsonData['genres'],
    );
  }
}
