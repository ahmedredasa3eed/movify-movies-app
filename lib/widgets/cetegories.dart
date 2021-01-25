import 'package:flutter/material.dart';
import 'package:movify/services/categories_api.dart';

class Categories extends StatelessWidget {
  CategoriesApi categoriesApi = CategoriesApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categoriesApi.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: LinearProgressIndicator(
                backgroundColor: Colors.indigo,
              ),
            );
          }
          return Container(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff0f0c29).withOpacity(0.3),
                          Color(0xff0f0c29).withOpacity(0.1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data[index].name,
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 2,
                          width: 30,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
