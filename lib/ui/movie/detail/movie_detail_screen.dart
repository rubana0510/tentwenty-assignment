import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_app/ui/movie/detail/movie_detail_change_notifier.dart';
import 'package:movie_app/ui/movie/detail/movie_video_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = 'movie_detail';

  const MovieDetailScreen({super.key});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailChangeNotifier>(
      builder: (context, model, child) {
        String? releaseDate;
        if (!model.isLoading) {
          releaseDate = DateFormat.yMMMMd().format(model.detail!.releaseDate);
        }
        return model.isLoading
            ? Center(child: CircularProgressIndicator.adaptive())
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(350), // here the desired height
                  child: Stack(
                    children: [
                      Image.network(
                        "http://image.tmdb.org/t/p/w500/${model.detail?.backdropPath}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        top: 0,
                        left: 16.0,
                        right: 16.0,
                        child: AppBar(
                          leading: IconButton(
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          title: Text("Watch",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                        ),
                      ),
                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text("In theatres ${releaseDate ?? ""}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 8.0,
                            ),
                            Center(
                              child: Container(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Color(0xff61C3F2), // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Rounded corners
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      "Get Tickets",
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Center(
                              child: Container(
                                width: 200,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VideoScreen(
                                                videoId: model.video!.results
                                                    .first.key)));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.blue, // Border color
                                    side: BorderSide(
                                        width: 1,
                                        color: Color(
                                            0xff61C3F2)), // Border width and color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Rounded corners
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Watch Trailer",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                body: _buildDetail(),
              );
      },
    );
  }

  Widget _buildDetail() {
    final model =
        Provider.of<MovieDetailChangeNotifier>(context, listen: false);

    if (model.isLoading) {
      return Center(child: CircularProgressIndicator.adaptive());
    }
    final failure = model.failure;
    if (failure != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(model.failure ?? ""),
            TextButton(
              onPressed: () {
                model.fetchMoviesDetail();
              },
              child: Text('Retry'),
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: const Text(
              "Genres",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Color(0xff202C43)),
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          SizedBox(
            width: double.infinity,
            height: 65,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: model.detail!.genres.length,
              itemBuilder: (context, index) {
                Color containerColor = getRandomColor();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      model.detail!.genres[index].name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 5.0),
          Divider(height: 1.0, color: Colors.grey.withOpacity(0.2)),
          const SizedBox(height: 5.0),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text("Overview",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Color(0xff202C43))),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(model.detail!.overview,
                style:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0)),
          ),
        ]),
      ),
    );
  }

  Color getRandomColor() {
    return Color(Random().nextInt(0xFFFFFFFF)).withOpacity(1.0);
  }
}
