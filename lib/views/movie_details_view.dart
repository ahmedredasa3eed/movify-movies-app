import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/models/movie.dart';
import 'package:movify/style/styles.dart';
import 'package:movify/widgets/film_item.dart';
import 'package:movify/widgets/reviews.dart';

class MovieDetails extends StatelessWidget {
  static const route = 'movie-details';

  @override
  Widget build(BuildContext context) {
    final movieData = ModalRoute.of(context).settings.arguments as Movie;
    return Scaffold(
      backgroundColor: Color(0xff302b63),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            forceElevated: false,
            floating: true,
            elevation: 3,
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            shadowColor: Color(0xff302b63),
            backgroundColor: Color(0xff302b63),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movieData.originalTitle),
              background: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/original" +
                    movieData.posterPath,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fadeInCurve: Curves.easeIn,
                fadeOutDuration: Duration(milliseconds: 1000),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.45,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: "https://image.tmdb.org/t/p/original" +
                                  movieData.posterPath,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fadeInCurve: Curves.easeIn,
                              fadeOutDuration: Duration(milliseconds: 1000),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieData.originalTitle,
                                  style: kTitleText.copyWith(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  "Release Data : ${movieData.releaseDate}",
                                  style: kHintText,
                                ),
                                Text(
                                  "Status : ${movieData.status}",
                                  style: kHintText,
                                ),
                                Text(
                                  "Vote Count : ${movieData.voteCount}",
                                  style: kHintText,
                                ),
                                Text(
                                  "Vote Average : ${movieData.voteAverage * 10} %",
                                  style: kHintText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        movieData.overview,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 15,
                        style: kHintText.copyWith(
                            color: Colors.white, fontSize: 18,height:1.5),
                      ),
                    ),
                  ),
                ),
                Divider(),
                UsersReviews(id:movieData.id),
                Divider(),
                FilmItem(urlSegment: "${movieData.id}/similar",title: "Similar Movies",)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
