import 'package:movie_app/data/network/dto/movie_dto.dart';
import 'package:movie_app/data/network/dto/movie_video_dto.dart';

import 'package:movie_app/repository/movie/movie_repository.dart';

import '../../data/network/dto/movie_detail_dto.dart';
import '../../data/network/dto/movie_search_dto.dart';

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<List<MovieModel>> fetchMovies(int page) async {
    const limit = 15;
    final response =
        await apiClient.getMovies({'page': page, 'per_page': limit});
    final movies = MovieResponse.fromJson(response.data).results;
    return movies;
  }

  @override
  Future<List<MovieResult>> fetchSearchMovies(String query) async {
    final response = await apiClient.getSearchMovies({'query': query});
    final search = MovieSearchResponse.fromJson(response.data).results;
    return search;
  }

  @override
  Future<MovieDetailResponse> fetchMovieDetail(int movieId) async {
    final response = await apiClient.getMovieDetail(movieId);
    final movie = MovieDetailResponse.fromJson(response.data);
    return movie;
  }

  @override
  Future<MovieVideoResponse> fetchMovieVideo(int movieId) async {
    final response = await apiClient.getMovieVideo(movieId);
    final movie = MovieVideoResponse.fromJson(response.data);
    return movie;
  }
}
