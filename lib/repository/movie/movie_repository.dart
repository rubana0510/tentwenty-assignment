import '../../data/network/dto/movie_detail_dto.dart';
import '../../data/network/dto/movie_dto.dart';
import '../../data/network/dto/movie_search_dto.dart';
import '../../data/network/dto/movie_video_dto.dart';
import '../base_repository.dart';

abstract class MovieRepository extends BaseRepository {
  Future<List<MovieModel>> fetchMovies(int page);
  Future<List<MovieResult>> fetchSearchMovies(String query);
  Future<MovieDetailResponse> fetchMovieDetail(int id);
  Future<MovieVideoResponse> fetchMovieVideo(int id);
}
