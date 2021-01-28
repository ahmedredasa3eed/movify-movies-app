import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movify/style/styles.dart';
import 'package:movify/utils/local_notifications.dart';
import 'package:movify/views/auth.dart';
import 'package:movify/widgets/cetegories.dart';
import 'package:movify/widgets/film_item.dart';
import 'package:movify/widgets/image_slider.dart';
import 'package:movify/widgets/search_input.dart';

class HomeScreen extends StatefulWidget {
  static const route = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  LocalNotification localNotification = LocalNotification();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff302b63),
                Color(0xff0f0c29),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 95,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LocalNotification()));
                      },
                          child: Text("Movies Land")),
                      SizedBox(height: 16),
                      SearchInput(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                pinned: true,
                backgroundColor: Color(0xff302b63),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Explore",
                                style: kTitleText.copyWith(
                                    fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacementNamed(
                                      context, AuthScreen.route);
                                },
                                icon: Icon(Icons.exit_to_app),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ImageSlider(),
                      SizedBox(height: 16),
                      Categories(),
                      SizedBox(height: 16),
                      FilmItem(
                        urlSegment: "popular",
                        title: "Popular Movies",
                      ),
                      FilmItem(
                        urlSegment: "top_rated",
                        title: "Top Rated Movies",
                      ),
                      FilmItem(
                        urlSegment: "upcoming",
                        title: "Upcoming Movies",
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
