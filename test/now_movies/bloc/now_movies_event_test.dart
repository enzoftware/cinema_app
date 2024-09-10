import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NowMoviesEvent', () {
    test('FetchNowPlayingMovies supports value comparison', () {
      // Arrange & Act
      const fetchEvent1 = FetchNowPlayingMovies();
      const fetchEvent2 = FetchNowPlayingMovies();

      // Assert
      expect(fetchEvent1, fetchEvent2); // Ensure value equality
    });

    test('SortNowMoviesAlphabetically supports value comparison', () {
      // Arrange & Act
      const sortEvent1 = SortNowMoviesAlphabetically();
      const sortEvent2 = SortNowMoviesAlphabetically();

      // Assert
      expect(sortEvent1, sortEvent2); // Ensure value equality
    });
  });
}
