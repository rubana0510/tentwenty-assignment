import 'package:flutter/cupertino.dart';
import 'package:movie_app/repository/movie/movie_repository_impl.dart';

import '../../../data/network/dto/movie_search_dto.dart';
import '../../../repository/movie/movie_repository.dart';

class MovieSearchChangeNotifier extends ChangeNotifier {
  int _page = 1;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isOver = false;
  bool get isOver => _isOver;
  String? _failure;
  String? get failure => _failure;
  List<MovieResult> _list = [];
  List<MovieResult> get list => _list;

  MovieRepository repository = MovieRepositoryImpl();
  String query = "";
  MovieSearchChangeNotifier() {
    fetchSearchMovies("");
  }

  void fetchSearchMovies(String query) async {
    try {
      if (_isLoading || _isOver) {
        return;
      }
      _failure = null;
      _isLoading = true;
      _list.clear();
      notifyListeners();
      final result = await repository.fetchSearchMovies(query);
      if (result.isEmpty) {
        _failure = "Enter Search Query";
      } else {
        _isOver = result.isEmpty;
        _page++;
      }
      _list.addAll(result);
    } catch (e, stack) {
      _failure = "Some Error Occurred";
      debugPrintStack(stackTrace: stack);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
