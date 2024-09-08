import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_models/cinema_models.dart';

/// {@template movie_repository}
/// movies repository
/// {@endtemplate}
class MovieRepository {
  MovieRepository({
    required CinemaApiClient apiClient,
  }) : _apiClient = apiClient;

  final CinemaApiClient _apiClient;

  Future<CinemaMovieApiResponse> fetchPopularMovies({int page = 1}) async {
    final response =
        await _apiClient.movieResource.fetchPopularMovies(page: page);
    return response;
  }

  Future<CinemaMovieApiResponse> fetchNowPlayingMovies({int page = 1}) async {
    final today = DateTime.now();
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));

    final response = await _apiClient.movieResource.fetchNowPlayingMovies(
      page: page,
      today: today.toFormattedDate(),
      weekAgo: weekAgo.toFormattedDate(),
    );
    return response;
  }
}
