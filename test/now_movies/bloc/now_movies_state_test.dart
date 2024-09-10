import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NowMoviesState', () {
    test('NowMoviesInitialLoading supports value equality', () {
      expect(
        NowMoviesInitialLoading(),
        equals(NowMoviesInitialLoading()),
      );
    });

    test('NowMoviesError supports value equality', () {
      const errorState1 = NowMoviesError(message: 'An error occurred');
      const errorState2 = NowMoviesError(message: 'An error occurred');
      const errorState3 = NowMoviesError(message: 'A different error');

      expect(errorState1, equals(errorState2));
      expect(errorState1, isNot(equals(errorState3)));
    });

    test('NowMoviesError props are correct', () {
      const errorState = NowMoviesError(message: 'An error occurred');
      expect(errorState.props, ['An error occurred']);
    });

    group('NowMoviesDataLoaded', () {
      const movie1 = MovieResult(id: 1, title: 'Movie 1');
      const movie2 = MovieResult(id: 2, title: 'Movie 2');
      final movies = [movie1, movie2];
      const favoriteMoviesIds = ['1', '2'];

      test('supports value equality', () {
        final state1 = NowMoviesDataLoaded(
          movies: movies,
          favoriteMoviesIds: favoriteMoviesIds,
        );
        final state2 = NowMoviesDataLoaded(
          movies: movies,
          favoriteMoviesIds: favoriteMoviesIds,
        );

        expect(state1, equals(state2));
      });

      test('props are correct', () {
        final state = NowMoviesDataLoaded(
          movies: movies,
          favoriteMoviesIds: favoriteMoviesIds,
          isLoadingMore: true,
        );

        expect(
          state.props,
          [movies, favoriteMoviesIds, true],
        );
      });

      test('copyWith creates a copy with updated values', () {
        final originalState = NowMoviesDataLoaded(
          movies: movies,
          favoriteMoviesIds: favoriteMoviesIds,
        );

        final updatedState = originalState.copyWith(isLoadingMore: true);

        expect(updatedState.isLoadingMore, true);
        expect(updatedState.movies, movies);
        expect(updatedState.favoriteMoviesIds, favoriteMoviesIds);

        final newMovies = [movie2];
        final updatedStateWithNewMovies =
            originalState.copyWith(movies: newMovies);

        expect(updatedStateWithNewMovies.movies, newMovies);
        expect(updatedStateWithNewMovies.isLoadingMore, false);
      });

      test('copyWith returns the same object if no arguments are passed', () {
        final state = NowMoviesDataLoaded(
          movies: movies,
          favoriteMoviesIds: favoriteMoviesIds,
        );

        expect(state.copyWith(), equals(state));
      });
    });
  });
}
