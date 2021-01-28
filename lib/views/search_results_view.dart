import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/services/movies_api.dart';
import 'package:movify/style/styles.dart';
import 'package:movify/view_models/movies_list_view_model.dart';
import 'package:movify/views/movie_details_view.dart';
import 'package:movify/widgets/loading.dart';
import 'package:provider/provider.dart';

class SearchResultsScreen extends StatelessWidget {

  static const route = 'search-result-screen';

  final MovieApi movieApi = MovieApi();

  @override
  Widget build(BuildContext context) {
    final keyword = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      backgroundColor: Color(0xff302b63),
      appBar: AppBar(
        title: Text("Search Results"),
        shadowColor: Color(0xff302b63),
        backgroundColor: Color(0xff302b63),
      ),
      body: FutureBuilder(
        future: Provider.of<MoviesListViewModel>(context).getSearchResult(keyword),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return Container(
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, MovieDetails.route,arguments: snapshot.data[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: "https://image.tmdb.org/t/p/original"+snapshot.data[index].posterPath,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fadeInCurve: Curves.easeIn,
                                  fadeOutDuration: Duration(milliseconds: 1000),
                                  fit: BoxFit.cover,
                                  height: 100,
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 150,
                                    child: Text(
                                      snapshot.data[index].originalTitle,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: kTitleText.copyWith(
                                          color: Colors.black, fontSize: 19),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Rating : ${snapshot.data[index].voteAverage * 10}",
                                    style: kHintText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
