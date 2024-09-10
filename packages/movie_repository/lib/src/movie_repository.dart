import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:shared_storage/shared_storage.dart';

/// {@template fetch_popular_movies_exception}
/// Exception thrown when fetching popular movies fails from the Cinema API.
///
/// This exception wraps any error that occurs during the process of fetching
/// popular movies, providing detailed error information.
/// {@endtemplate}
class FetchPopularMoviesException implements Exception {
  /// {@macro fetch_popular_movies_exception}
  FetchPopularMoviesException(this.error);

  /// The error that caused the exception.
  final dynamic error;

  @override
  String toString() {
    return 'FetchPopularMoviesException: $error';
  }
}

/// {@template fetch_now_playing_movies_exception}
/// Exception thrown when fetching now playing movies fails from the Cinema API.
///
/// This exception wraps any error that occurs during the process of fetching
/// now playing movies, providing detailed error information.
/// {@endtemplate}
class FetchNowPlayingMoviesException implements Exception {
  /// {@macro fetch_now_playing_movies_exception}
  FetchNowPlayingMoviesException(this.error);

  /// The error that caused the exception.
  final dynamic error;

  @override
  String toString() {
    return 'FetchNowPlayingMoviesException: $error';
  }
}

/// {@template movie_repository}
/// A repository that provides methods to fetch movie data from the Cinema API.
///
/// The repository offers methods to fetch popular movies and now playing movies
/// It handles errors by throwing specific exceptions for each case:
///
/// - [FetchPopularMoviesException]: thrown when fetching popular movies fails.
/// - [FetchNowPlayingMoviesException]: thrown when fetching now playing movies
/// fails.
///
/// This repository also allows for saving and managing favorite movies locally
/// through the provided [MovieLocalDatabase].
/// {@endtemplate}
class MovieRepository {
  /// {@macro movie_repository}
  MovieRepository({
    required CinemaApiClient apiClient,
    required MovieLocalDatabase localDatabase,
  })  : _apiClient = apiClient,
        _localDatabase = localDatabase;

  /// The client used to communicate with the Cinema API.
  final CinemaApiClient _apiClient;

  /// The local database used for storing and retrieving favorite movies.
  final MovieLocalDatabase _localDatabase;

  /// Adds a new movie to the list of favorite movies.
  ///
  /// - [movie]: The movie to be added to favorites.
  void addNewFavoriteMovie(MovieResult movie) {
    _localDatabase.addFavoriteMovie(movie.id.toString());
  }

  /// Removes a movie from the list of favorite movies by its [id].
  ///
  /// - [id]: The ID of the movie to be removed from favorites.
  void removeFavoriteMovie({required int id}) {
    _localDatabase.removeFavoriteMovieById(id);
  }

  /// Retrieves the list of favorite movie IDs.
  ///
  /// Returns a list of movie IDs as strings.
  List<String> getFavoriteMoviesIds() {
    return _localDatabase.getFavoriteMovies();
  }

  /// Fetches a list of popular movies from the Cinema API.
  ///
  /// - [page]: The page number to fetch. Defaults to page 1.
  ///
  /// Throws a [FetchPopularMoviesException] if the request fails.
  Future<CinemaMovieApiResponse> fetchPopularMovies({int page = 1}) async {
    try {
      final response =
          await _apiClient.movieResource.fetchPopularMovies(page: page);
      return response;
    } catch (e) {
      throw FetchPopularMoviesException(e);
    }
  }

  /// Fetches a list of now playing movies from the Cinema API.
  ///
  /// - [page]: The page number to fetch. Defaults to page 1.
  ///
  /// This method fetches movies that are currently playing in theaters,
  /// filtering
  /// them by release date to ensure only relevant results are returned.
  ///
  /// Throws a [FetchNowPlayingMoviesException] if the request fails.
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
