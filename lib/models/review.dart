class Review{
  String author;
  String username;
  String avatarPath;
  final rating;
  String content;

  Review(
  {this.author, this.username, this.avatarPath, this.rating, this.content});

  factory Review.fromJson(Map<String,dynamic> jsonData){
    return Review(
      author: jsonData['author'],
      username: jsonData['author_details']['username'],
      avatarPath: jsonData['author_details']['avatar_path'],
      rating: jsonData['author_details']['rating'],
      content: jsonData['content'],
    );
  }
}

class ReviewsList{
  List<dynamic> reviews;

  ReviewsList(
      {this.reviews});

  factory ReviewsList.fromJson(Map<String,dynamic> jsonData){
    return ReviewsList(
      reviews: jsonData['results'],
    );
  }
}