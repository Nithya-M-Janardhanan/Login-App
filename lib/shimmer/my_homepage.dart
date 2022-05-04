import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_widget.dart';
import 'movie_data.dart';
import 'movie_model.dart';
class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  List<MovieModel> movies = [];
  bool isLoading = false;

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    movies = List.of(allMovies);
    setState(() {
      isLoading = false;
    });
  }

  Widget buildMovieList(MovieModel model) =>
      ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(model.urlImg),
        ),
        title: Text(model.title, style: const TextStyle(fontSize: 16),),
        subtitle: Text(
          model.detail, style: const TextStyle(fontSize: 14), maxLines: 1,),
      );

  Widget buildMovieShimmer() =>
      ListTile(
        leading: const CustomWidget.circular(height: 64, width: 64),
        title: Align(
          alignment: Alignment.centerLeft,
          child: CustomWidget.rectangular(height: 16,
            width: MediaQuery.of(context).size.width*0.3,),
        ),
        subtitle: const CustomWidget.rectangular(height: 14),
      );

  @override
  void initState() {

    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: isLoading? 5: movies.length,
          itemBuilder: (context, index) {
            if (isLoading) {
              return buildMovieShimmer();
            } else {
              final movie = movies[index];
              return buildMovieList(movie);
            }
          }
      ),
    );
  }
}
