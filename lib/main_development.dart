import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/bootstrap.dart';
import 'package:movie_repository/movie_repository.dart';

void main() {
  bootstrap(() async {
    final apiClient = CinemaApiClient('https://api.themoviedb.org/3');
    final movieRepository = MovieRepository(apiClient: apiClient);
    return CinemaMovieApp(movieRepository: movieRepository);
  });
}
