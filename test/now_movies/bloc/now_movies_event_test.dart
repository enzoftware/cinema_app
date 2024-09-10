import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NowMoviesEvent', () {
    test('FetchNowPlayingMovies supports value comparison', () {
      const fetchEvent1 = FetchNowPlayingMovies();
      const fetchEvent2 = FetchNowPlayingMovies();

      expect(fetchEvent1, fetchEvent2);
    });

    test('SortNowMoviesAlphabetically supports value comparison', () {
      const sortEvent1 = SortNowMoviesAlphabetically();
      const sortEvent2 = SortNowMoviesAlphabetically();

      expect(sortEvent1, sortEvent2);
    });
  });
}
