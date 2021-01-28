import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/models/movie.dart';
import 'package:movify/style/styles.dart';
import 'package:movify/view_models/movies_list_view_model.dart';
import 'package:movify/views/movie_details_view.dart';
import 'package:movify/widgets/loading.dart';
import 'package:provider/provider.dart';

class FilmItem extends StatelessWidget {

  final String urlSegment;
  final String title;
  FilmItem({this.urlSegment,this.title});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MoviesListViewModel>(context).fetchAllMovies(urlSegment),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Loading();
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style:
                      kTitleText.copyWith(fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              height: 340,
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List<Movie> movieData = snapshot.data;
                    final imageUrl = "https://image.tmdb.org/t/p/original"+movieData[index].posterPath;
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, MovieDetails.route,arguments: movieData[index]);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                fadeInCurve: Curves.easeIn,
                                fadeOutDuration: Duration(milliseconds: 1000),
                                fit: BoxFit.cover,
                                height: 250,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.favorite_outlined,color: Colors.red,),
                                SizedBox(width: 8),
                                Text("${movieData[index].voteAverage * 10}%",style: TextStyle(color: Colors.white,fontSize:14),),
                              ],
                            ),
                            SizedBox(height: 8),
                            Expanded(child: Text("${movieData[index].originalTitle}",style: TextStyle(color: Colors.white,fontSize:16),)),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      }
    );
  }
}
