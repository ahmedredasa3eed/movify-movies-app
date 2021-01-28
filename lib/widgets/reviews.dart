import 'package:flutter/material.dart';
import 'package:movify/models/review.dart';
import 'package:movify/services/reviews_api.dart';
import 'package:movify/style/styles.dart';
import 'package:movify/view_models/review_view_model.dart';
import 'package:provider/provider.dart';

class UsersReviews extends StatelessWidget {

  final int id;
  UsersReviews({this.id});

  ReviewsApi reviewsApi = ReviewsApi();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reviews",
                    style: kTitleText.copyWith(fontWeight: FontWeight.bold)),
                Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: Provider.of<ReviewsViewModel>(context).fetchAllReviews(id),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.indigo,
                  ),
                );
              }
              if(!snapshot.hasData){
                return Container(
                  child: Text("No reviews Found",style: kHintText,),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List<Review> reviewData = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(reviewData[index].username,
                                      style: kTitleText.copyWith(
                                          color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 7),
                                    Text(reviewData[index].content,
                                      style: kHintText.copyWith(color: Colors.white,fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
