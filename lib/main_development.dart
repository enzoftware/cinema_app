import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/bootstrap.dart';
import 'package:dio/dio.dart';
import 'package:movie_repository/movie_repository.dart';

void main() {
  bootstrap(() async {
    const apiKey = String.fromEnvironment('API_KEY');
    const baseUrl = 'https://api.themoviedb.org/3';
    final httpClient = Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(LogInterceptor(requestBody: true));

    final apiClient = CinemaApiClient(
      baseUrl,
      apiKey: apiKey,
      httpClient: httpClient,
    );
    final movieRepository = MovieRepository(apiClient: apiClient);
    return CinemaMovieApp(movieRepository: movieRepository);
  });
}
