import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:dio/dio.dart';

/// {@template movie_resource}
/// A resource class that provides methods to fetch movie-related data from the
/// API.
///
/// It uses the [CinemaApiClient] to make HTTP requests and return deserialized
/// instances of [CinemaMovieApiResponse].
///
/// The following movie-related data can be fetched:
/// - Popular movies
/// - Now playing movies
///
/// This class handles errors using the [CinemaApiError] when API requests fail.
/// {@endtemplate}
class MovieResource {
  /// {@macro movie_resource}
  MovieResource({required CinemaApiClient apiClient}) : _apiClient = apiClient;

  final CinemaApiClient _apiClient;

  /// {@template fetch_popular_movies}
  /// Fetches a list of popular movies from the API.
  ///
  /// The movies are sorted by popularity in descending order.
  ///
  /// - [page]: The page number to fetch. Defaults to `1`.
  ///
  /// Throws a [CinemaApiError] if the request fails.
  /// {@endtemplate}
  Future<CinemaMovieApiResponse> fetchPopularMovies({int page = 1}) async {
    const url = '/discover/movie';
    try {
      final queryParameters = {
        'include_adult': false,
        'include_video': false,
        'language': 'en-US',
        'page': page,
        'sort_by': 'popularity.desc',
      };
      final response = await _apiClient.makeRequest<Map<String, dynamic>>(
        url: url,
        queryParameters: queryParameters,
      );
      return CinemaMovieApiResponse.fromJson(response.data!);
    } on DioException catch (error) {
      throw CinemaApiError(error: error.response?.data);
    } catch (error) {
      throw CinemaApiError(error: error);
    }
  }

  /// {@template fetch_now_playing_movies}
  /// Fetches a list of movies that are currently playing in theaters from the
  /// API.
  ///
  /// The movies are filtered based on their release date.
  ///
  /// - [today]: The current date (formatted as `YYYY-MM-DD`) to filter movies
  /// up to today.
  /// - [weekAgo]: A date (formatted as `YYYY-MM-DD`) to filter movies starting
  /// from a week ago.
  /// - [page]: The page number to fetch. Defaults to `1`.
  ///
  /// Throws a [CinemaApiError] if the request fails.
  /// {@endtemplate}
  Future<CinemaMovieApiResponse> fetchNowPlayingMovies({
    required String today,
    required String weekAgo,
    int page = 1,
  }) async {
    const url = '/discover/movie';

    try {
      final queryParameters = {
        'include_adult': false,
        'include_video': false,
        'language': 'en-US',
        'page': page,
        'sort_by': 'popularity.desc',
        'with_release_type': '2|3',
        'release_date.gte': weekAgo,
        'release_date.lte': today,
      };
      final response = await _apiClient.makeRequest<Map<String, dynamic>>(
        url: url,
        queryParameters: queryParameters,
      );
      return CinemaMovieApiResponse.fromJson(response.data!);
    } on DioException catch (error) {
      throw CinemaApiError(error: error.response?.data);
    } catch (error) {
      throw CinemaApiError(error: error);
    }
  }
}
