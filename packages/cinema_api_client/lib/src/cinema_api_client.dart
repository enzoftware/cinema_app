import 'package:cinema_api_client/src/resources/movie_resource.dart';
import 'package:dio/dio.dart';

/// {@template cinema_api_client}
/// A client for interacting with the Cinema API (such as TMDB API).
///
/// This client is responsible for handling API requests to the Cinema API,
/// including making HTTP requests, adding headers, and managing resources
/// like [MovieResource].
///
/// The client uses [Dio] for HTTP requests and allows users to inject a custom
/// [Dio] instance if needed.
///
/// The client provides access to various resources:
/// - [movieResource] to interact with movie-related endpoints.
///
/// Example usage:
/// ```dart
/// final apiClient = CinemaApiClient('https://api.themoviedb.org/3');
/// final popularMovies = await apiClient.movieResource.fetchPopularMovies();
/// ```
/// {@endtemplate}
class CinemaApiClient {
  /// {@macro cinema_api_client}
  CinemaApiClient(
    String baseUrl, {
    required String apiKey,
    Dio? httpClient,
  })  : _httpClient = httpClient ?? Dio(BaseOptions(baseUrl: baseUrl)),
        _apiKey = apiKey;

  final Dio _httpClient;
  final String _apiKey;

  /// Provides access to movie-related API endpoints.
  ///
  /// This instance of [MovieResource] initialized with this [CinemaApiClient]
  /// and allows for fetching popular movies, now playing movies, etc.
  ///
  late final movieResource = MovieResource(apiClient: this);

  /// Makes a request to the Cinema API.
  ///
  /// - [url]: The endpoint to be requested.
  /// - [method]: The HTTP method (GET, POST, etc.). Defaults to `GET`.
  /// - [headers]: Optional headers to add to the request. If none are provided,
  ///   a default `Authorization` header with a bearer token is used.
  ///
  /// Returns a [Response] object that contains the API response.
  ///
  /// Throws:
  /// - [DioException] if the request fails due to network issues or bad
  /// responses.
  ///
  /// Example usage:
  /// ```dart
  /// final response = await apiClient.makeRequest<Map<String, dynamic>>(url: '/movie/123');
  /// ```
  Future<Response<T>> makeRequest<T>({
    required String url,
    String method = 'GET',
    Map<String, String>? headers,
    Map<String, Object> queryParameters = const {},
  }) async {
    final mutableQueryParameters = Map<String, Object>.from(queryParameters)
      ..addAll({
        'api_key': _apiKey,
      });

    return _httpClient.request(
      url,
      queryParameters: mutableQueryParameters,
      options: Options(
        headers: headers ??
            {
              'accept': 'application/json',
            },
        method: method,
      ),
    );
  }
}

/// {@template cinema_api_error}
/// A custom exception class for handling errors returned by the Cinema API.
///
/// This class wraps the underlying error (such as network issues or bad API
/// responses),
/// providing a way to inspect the error details.
///
/// Example:
/// ```dart
/// try {
///   final popularMovies = await apiClient.movieResource.fetchPopularMovies();
/// } catch (e) {
///   if (e is CinemaApiError) {
///     print('API error: ${e.toString()}');
///   }
/// }
/// ```
/// {@endtemplate}
class CinemaApiError implements Exception {
  /// {@macro cinema_api_error}
  CinemaApiError({required this.error});

  /// The error details returned from the API.
  final dynamic error;

  @override
  String toString() {
    return error.toString();
  }
}
