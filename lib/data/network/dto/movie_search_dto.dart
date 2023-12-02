// To parse this JSON data, do
//
//     final movieSearchResponse = movieSearchResponseFromJson(jsonString);

import 'dart:convert';

MovieSearchResponse movieSearchResponseFromJson(String str) => MovieSearchResponse.fromJson(json.decode(str));

String movieSearchResponseToJson(MovieSearchResponse data) => json.encode(data.toJson());

class MovieSearchResponse {
  int page;
  List<MovieResult> results;
  int totalPages;
  int totalResults;

  MovieSearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) => MovieSearchResponse(
    page: json["page"],
    results: List<MovieResult>.from(json["results"].map((x) => MovieResult.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class MovieResult {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieResult({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieResult.fromJson(Map<String, dynamic> json) => MovieResult(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
