class Movie {
  int id;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  final voteCount;
  final voteAverage;
  String status;

  Movie(
      {this.id,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.voteCount,
      this.voteAverage,
      this.status});

  factory Movie.fromJson(Map<String, dynamic> jsonData) {
    return Movie(
      id: jsonData['id'],
      originalTitle: jsonData['original_title'],
      overview: jsonData['overview'],
      posterPath: jsonData['poster_path'],
      releaseDate: jsonData['release_date'],
      voteCount: jsonData['vote_count'],
      voteAverage: jsonData['vote_average'],
      status: jsonData['status'],
    );
  }
}

class MoviesList {
  List<dynamic> movies;

  MoviesList({this.movies});

  factory MoviesList.fromJson(Map<String, dynamic> jsonData1) {
    return MoviesList(
      movies: jsonData1['results'],
    );
  }
}
