import 'package:cinema_app/popular_movies/bloc/popular_movies_bloc.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PopularMoviesState', () {
    test('PopularMoviesInitialLoading supports value equality', () {
      expect(
        PopularMoviesInitialLoading(),
        equals(PopularMoviesInitialLoading()),
      );
    });

    test('PopularMoviesLoaded supports value equality', () {
      final movies = [const MovieResult(id: 1, title: 'Movie 1')];
      expect(
        PopularMoviesLoaded(movies: movies),
        equals(PopularMoviesLoaded(movies: movies)),
      );
    });

    test('PopularMoviesLoaded has correct props', () {
      final movies = [const MovieResult(id: 1, title: 'Movie 1')];
      expect(
        PopularMoviesLoaded(movies: movies).props,
        equals([movies, <MovieResult>[], false]),
      );
    });

    test(
        'PopularMoviesLoaded copyWith returns new instance with updated values',
        () {
      final movies = [const MovieResult(id: 1, title: 'Movie 1')];
      final favoriteMovies = ['1'];

      final originalState = PopularMoviesLoaded(
        movies: movies,
        favoriteMovies: favoriteMovies,
      );

      final updatedState = originalState.copyWith(
        isLoadingMore: true,
      );

      expect(updatedState.isLoadingMore, true);
      expect(updatedState.movies, movies);
      expect(
        updatedState.favoriteMovies,
        favoriteMovies,
      );
    });

    test('PopularMoviesError supports value equality', () {
      expect(
        const PopularMoviesError(message: 'Error message'),
        equals(const PopularMoviesError(message: 'Error message')),
      );
    });

    test('PopularMoviesError has correct props', () {
      expect(
        const PopularMoviesError(message: 'Error message').props,
        equals(['Error message']),
      );
    });
  });
}
