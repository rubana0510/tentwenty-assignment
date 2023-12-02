import 'package:flutter/material.dart';
import 'package:movie_app/ui/movie/detail/movie_detail_change_notifier.dart';
import 'package:movie_app/ui/movie/movie_change_notifier.dart';
import 'package:movie_app/ui/movie/search/movie_search_notifier.dart';
import 'package:provider/provider.dart';

import '../detail/movie_detail_screen.dart';

class MovieSearch extends StatefulWidget {
  static const String routeName = 'movie_search';

  const MovieSearch({super.key});

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieSearchChangeNotifier>(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Enter your search term',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(30.0)),
                    suffixIcon: InkWell(
                        onTap: () {
                          _searchController.clear();
                        },
                        child: Icon(Icons.clear)),
                    filled: true,
                    fillColor: Color(0xffEFEFEF),
                  ),
                  onSubmitted: (value) {
                    model.fetchSearchMovies(value);
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(child: _buildList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    final model =
        Provider.of<MovieSearchChangeNotifier>(context, listen: false);
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
                model.fetchSearchMovies("");
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
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          MovieDetailScreen.routeName,
                          arguments: list[index].id);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              "http://image.tmdb.org/t/p/w500/${list[index].posterPath}",
                              fit: BoxFit.cover,
                              width: 130,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              list[index].title,
                              maxLines: 4,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ])));
          },
        ),
      ),
    );
  }
}
