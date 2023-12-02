import 'package:flutter/material.dart';
import 'package:movie_app/ui/movie/detail/movie_detail_screen.dart';
import 'package:movie_app/ui/movie/search/movie__search.dart';
import 'package:provider/provider.dart';

import '../../data/network/util/error_util.dart';
import 'movie_change_notifier.dart';

class MovieList extends StatefulWidget {
  static const String routeName = 'movie';

  const MovieList({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    final model = Provider.of<MovieChangeNotifier>(context, listen: false);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        model.fetchMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieChangeNotifier>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text('Watch'), actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                MovieSearch.routeName,
              );
            },
          )
        ]),
        body: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    final model = Provider.of<MovieChangeNotifier>(context, listen: false);
    final list = model.list;

    if (model.isLoading && list.isEmpty) {
      return Center(child: CircularProgressIndicator.adaptive());
    }
    final failure = model.failure;
    if (failure != null && list.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(model.failure ?? ""),
            TextButton(
              onPressed: () {
                model.fetchMovies();
              },
              child: Text('Retry'),
            )
          ],
        ),
      );
    }

    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            ListView.builder(
              itemCount: list.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          MovieDetailScreen.routeName,
                          arguments: list[index].id);
                    },
                    child: Stack(children: [
                      Container(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "http://image.tmdb.org/t/p/w500/${list[index].posterPath}",
                            height: 200,
                            // width: 200,
                            fit: BoxFit
                                .cover, // Ensure the image covers the entire space
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          // Adjust the color and opacity as needed
                          child: Text(
                            list[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
            Visibility(
              visible: model.isLoading && !model.isOver,
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
            if (model.failure != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(model.failure ?? ""),
                    TextButton(
                      onPressed: () {
                        model.fetchMovies();
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
