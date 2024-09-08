import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_models/cinema_models.dart';

/// {@template fetch_popular_movies_exception}
/// Exception thrown when fetching popular movies fails.
/// {@endtemplate}
class FetchPopularMoviesException implements Exception {
  /// {@macro fetch_popular_movies_exception}
  FetchPopularMoviesException(this.error);

  /// The error that was thrown.
  final dynamic error;

  @override
  String toString() {
    return 'FetchPopularMoviesException: $error';
  }
}

/// {@template fetch_now_playing_movies_exception}
/// Exception thrown when fetching now playing movies fails.
/// {@endtemplate}
class FetchNowPlayingMoviesException implements Exception {
  /// {@macro fetch_now_playing_movies_exception}
  FetchNowPlayingMoviesException(this.error);

  /// The error that was thrown.
  final dynamic error;

  @override
  String toString() {
    return 'FetchNowPlayingMoviesException: $error';
  }
}

/// {@template movie_repository}
/// A repository that provides methods for fetching movies from the Cinema API.
///
/// It supports fetching popular movies and now playing movies. The repository
/// handles errors gracefully by throwing specific exceptions for each case.
/// - [FetchPopularMoviesException] thrown when fetching popular movies fails.
/// - [FetchNowPlayingMoviesException] is thrown when fetching now playing
/// movies fails.
/// {@endtemplate}
class MovieRepository {
  /// {@macro movie_repository}
  MovieRepository({
    required CinemaApiClient apiClient,
  }) : _apiClient = apiClient;

  final CinemaApiClient _apiClient;

  /// Fetches the popular movies from the Cinema API.
  ///
  /// Throws a [FetchPopularMoviesException] if an error occurs during fetching.
  ///
  /// - [page] specifies which page of the popular movies to fetch, defaulting
  /// to page 1.
  Future<CinemaMovieApiResponse> fetchPopularMovies({int page = 1}) async {
    try {
      final response =
          await _apiClient.movieResource.fetchPopularMovies(page: page);
      return response;
    } catch (e) {
      throw FetchPopularMoviesException(e);
    }
  }

  /// Fetches the now playing movies from the Cinema API.
  ///
  /// Throws a [FetchNowPlayingMoviesException] if an error occurs during
  /// fetching.
  ///
  /// - [page] specifies which page of the now playing movies to fetch,
  /// defaulting to page 1.
  Future<CinemaMovieApiResponse> fetchNowPlayingMovies({int page = 1}) async {
    try {
      final today = DateTime.now();
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));

      final response = await _apiClient.movieResource.fetchNowPlayingMovies(
        page: page,
        today: today.toFormattedDate(),
        weekAgo: weekAgo.toFormattedDate(),
      );
      return response;
    } catch (e) {
      throw FetchNowPlayingMoviesException(e);
    }
  }
}
