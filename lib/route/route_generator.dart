import 'package:flutter/material.dart';
import 'package:movie_app/ui/movie/detail/movie_detail_change_notifier.dart';
import 'package:movie_app/ui/movie/detail/movie_detail_screen.dart';
import 'package:movie_app/ui/movie/movie_screen.dart';
import 'package:movie_app/ui/movie/search/movie__search.dart';
import 'package:movie_app/ui/movie/search/movie_search_notifier.dart';
import 'package:provider/provider.dart';

import '../ui/bottomNavigation/bottom_navigation_screen.dart';
import '../ui/movie/movie_change_notifier.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case BottomNavigationScreen.routeName:
        return MaterialPageRoute(builder: (_) => BottomNavigationScreen());
      case MovieList.routeName:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<MovieChangeNotifier>(
                  create: (_) => MovieChangeNotifier(),
                  child: MovieList(),
                ));
      case MovieDetailScreen.routeName:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<MovieDetailChangeNotifier>(
                  create: (_) => MovieDetailChangeNotifier(movieId),
                  child: const MovieDetailScreen(),
                ));
      case MovieSearch.routeName:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<MovieSearchChangeNotifier>(
                  create: (_) => MovieSearchChangeNotifier(),
                  child: const MovieSearch(),
                ));

      default:
        return buildErrorRoute();
    }
  }

  static Route<dynamic> buildErrorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Arggg!'),
          ),
          body: Center(
            child: Text('Oh No! You should not be here! '),
          ),
        );
      },
    );
  }
}
