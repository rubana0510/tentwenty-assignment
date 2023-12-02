import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/network/dto/movie_video_dto.dart';
import 'package:movie_app/repository/movie/movie_repository_impl.dart';

import '../../../data/network/dto/movie_detail_dto.dart';
import '../../../repository/movie/movie_repository.dart';

class MovieDetailChangeNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _failure;
  String? get failure => _failure;

  MovieDetailResponse? detail;
  MovieVideoResponse? video;

  MovieRepository repository = MovieRepositoryImpl();
  final int movieId;
  MovieDetailChangeNotifier(this.movieId) {
    fetchMoviesDetail();
  }

  void fetchMoviesDetail() async {
    try {
      if (_isLoading) {
        return;
      }

      _failure = null;
      _isLoading = true;
      notifyListeners();

      final result = await repository.fetchMovieDetail(movieId);
      final videoResult = await repository.fetchMovieVideo(movieId);

      detail = result;
      video = videoResult;
    } catch (e, stack) {
      _failure = "Some Error Occurred";
      debugPrintStack(stackTrace: stack);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
