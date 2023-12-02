import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/network/dto/movie_dto.dart';
import 'package:movie_app/repository/base_repository.dart';
import 'package:movie_app/repository/movie/movie_repository_impl.dart';

import '../../data/network/util/base_response.dart';
import '../../data/network/util/error_util.dart';
import '../../repository/movie/movie_repository.dart';

class MovieChangeNotifier extends ChangeNotifier {
  int _page = 1;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isOver = false;
  bool get isOver => _isOver;
  String? _failure;

  String? get failure => _failure;
  List<MovieModel> _list = [];
  List<MovieModel> get list => _list;
  MovieRepository repository = MovieRepositoryImpl();
  MovieChangeNotifier() {
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      if (_isLoading || _isOver) {
        return;
      }
      _failure = null;
      _isLoading = true;
      notifyListeners();
      final result = await repository.fetchMovies(_page);
      if (result.isEmpty) {
        _failure = "Some Error Occurred";
      } else {
        _isOver = result.isEmpty;
        _page++;
      }
      _list.addAll(result);
    } catch (e, stack) {
      _failure = "Some Error Occurred";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
