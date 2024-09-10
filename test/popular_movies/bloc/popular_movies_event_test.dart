import 'package:cinema_app/popular_movies/bloc/popular_movies_bloc.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PopularMoviesEvent', () {
    test('FetchPopularMovies supports value equality', () {
      expect(
        const FetchPopularMovies(),
        equals(const FetchPopularMovies()),
      );
    });

    test('AddNewFavoritePopularMovie supports value equality', () {
      const movieResult = MovieResult(id: 1, title: 'Movie 1');
      expect(
        const AddNewFavoritePopularMovie(movieResult: movieResult),
        equals(const AddNewFavoritePopularMovie(movieResult: movieResult)),
      );
    });

    test('AddNewFavoritePopularMovie has correct props', () {
      const movieResult = MovieResult(id: 1, title: 'Movie 1');
      expect(
        const AddNewFavoritePopularMovie(movieResult: movieResult).props,
        equals([movieResult]),
      );
    });

    test('RemoveFavoritePopularMovie supports value equality', () {
      expect(
        const RemoveFavoritePopularMovie(movieId: 1),
        equals(const RemoveFavoritePopularMovie(movieId: 1)),
      );
    });

    test('RemoveFavoritePopularMovie has correct props', () {
      expect(
        const RemoveFavoritePopularMovie(movieId: 1).props,
        equals([1]),
      );
    });

    test('SortPopularMoviesAlphabetically supports value equality', () {
      expect(
        const SortPopularMoviesAlphabetically(),
        equals(const SortPopularMoviesAlphabetically()),
      );
    });
  });
}
