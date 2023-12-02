import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:movie_app/data/network/util/base_response.dart';

import 'endpoints.dart';

class ApiClient {
  final CancelToken cancelToken = CancelToken();
  static final ApiClient _singleton = new ApiClient._internal();
  late Dio dio;

  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal() {
    _init();
  }

  void _init() {
    dio = Dio();
    dio.options.baseUrl = BaseUrl.url;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters["api_key"] =
              "6470af551f906b0f51b9359dea3552fd";
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(
      requestBody: Foundation.kDebugMode,
      request: Foundation.kDebugMode,
      requestHeader: Foundation.kDebugMode,
      responseBody: Foundation.kDebugMode,
    ));
  }

  Future<ApiResponse> getMovies(Map<String, dynamic> queryParameters) {
    return _get(UrlPath.getMovies, queryParameters: queryParameters);
  }

  Future<ApiResponse> getSearchMovies(Map<String, dynamic> queryParameters) {
    return _get(UrlPath.getSearchMovies, queryParameters: queryParameters);
  }

  Future<ApiResponse> getMovieDetail(int id) {
    return _get(UrlPath.getMovieDetail + "$id");
  }

  Future<ApiResponse> getMovieVideo(int id) {
    return _get(UrlPath.getMovieDetail + "$id/videos");
  }

  Future<ApiResponse> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Response response = await dio.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return _getResponse(response);
    } on DioException catch (e) {
      throw _getError(e);
    }
  }

  Future<ApiResponse> _post(
    String path, {
    dynamic map,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: map,
        cancelToken: cancelToken,
      );
      return _getResponse(response);
    } on DioException catch (e) {
      throw _getError(e);
    }
  }

  ApiResponse _getResponse(Response response) {
    if (response.data != null) {
      return ApiResponse(response.data);
    }
    throw ApiError(ErrorType.apiFailure,
        code: "API_ERROR", message: "Error message");
  }

  ApiError _getError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(ErrorType.timeout);
        break;
      case DioExceptionType.badResponse:
        if (e.type == HttpStatus.unauthorized) {}
        final rawResponse = RawResponse.fromJson(e.response?.data);
        return ApiError(ErrorType.apiFailure,
            code: rawResponse.error?.code, message: rawResponse.error?.msg);

      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return ApiError(ErrorType.noConnection);
        }
        return ApiError(ErrorType.unknown);
      default:
        return ApiError(ErrorType.unknown);
    }
  }
}
