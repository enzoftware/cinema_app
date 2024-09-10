import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NowMoviesEvent', () {
    test('FetchNowPlayingMovies supports value equality', () {
      expect(
        const FetchNowPlayingMovies(),
        equals(const FetchNowPlayingMovies()),
      );
    });

    test('FetchNowPlayingMovies props are correct', () {
      expect(
        const FetchNowPlayingMovies().props,
        equals(<Object?>[]),
      );
    });

    test('AddNowPlayingFavoriteMovie supports value equality', () {
      const movieResult = MovieResult(id: 1, title: 'Movie Title');
      expect(
        const AddNowPlayingFavoriteMovie(movieResult),
        equals(const AddNowPlayingFavoriteMovie(movieResult)),
      );
    });

    test('AddNowPlayingFavoriteMovie props are correct', () {
      const movieResult = MovieResult(id: 1, title: 'Movie Title');
      expect(
        const AddNowPlayingFavoriteMovie(movieResult).props,
        equals([movieResult]),
      );
    });

    test('RemoveNowPlayingFavoriteMovie supports value equality', () {
      expect(
        const RemoveNowPlayingFavoriteMovie(movieId: 1),
        equals(const RemoveNowPlayingFavoriteMovie(movieId: 1)),
      );
    });

    test('RemoveNowPlayingFavoriteMovie props are correct', () {
      expect(
        const RemoveNowPlayingFavoriteMovie(movieId: 1).props,
        equals([1]),
      );
    });

    test('SortNowMoviesAlphabetically supports value equality', () {
      expect(
        const SortNowMoviesAlphabetically(),
        equals(const SortNowMoviesAlphabetically()),
      );
    });

    test('SortNowMoviesAlphabetically props are correct', () {
      expect(
        const SortNowMoviesAlphabetically().props,
        equals(<Object?>[]),
      );
    });
  });
}
