import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_storage/src/movie_local_database.dart';
import 'package:test/test.dart';

class MockBox extends Mock implements Box<List<String>> {}

void main() {
  late MockBox mockBox;
  late MovieLocalDatabase movieLocalDatabase;

  setUp(() {
    mockBox = MockBox();
    when(() => mockBox.put(any<String>(), any())).thenAnswer((_) async {});
    movieLocalDatabase = MovieLocalDatabase(mockBox);
  });

  group('MovieLocalDatabase', () {
    const favoriteMoviesKey = MovieLocalDatabase.favoriteMoviesKey;

    test('addFavoriteMovie adds a movie to the list and saves it', () {
      const newMovieId = '123';

      // Mock the getFavoriteMovies method to return an empty list initially
      when(() => mockBox.get(favoriteMoviesKey)).thenReturn([]);

      // Call the addFavoriteMovie method
      movieLocalDatabase.addFavoriteMovie(newMovieId);

      // Verify that the updated list with the new movie ID was saved to Hive
      verify(() => mockBox.put(favoriteMoviesKey, [newMovieId])).called(1);
    });

    test('getFavoriteMovies returns the list of favorite movies', () {
      const movieIds = ['101', '102', '103'];

      // Mock the Hive box to return a list of favorite movies
      when(() => mockBox.get(favoriteMoviesKey)).thenReturn(movieIds);

      final result = movieLocalDatabase.getFavoriteMovies();

      // Verify the returned result matches the mocked movie IDs
      expect(result, equals(movieIds));
      verify(() => mockBox.get(favoriteMoviesKey)).called(1);
    });

    test('getFavoriteMovies returns an empty list if no favorites are stored',
        () {
      // Mock the Hive box to return null (no favorite movies stored)
      when(() => mockBox.get(favoriteMoviesKey)).thenReturn(null);

      final result = movieLocalDatabase.getFavoriteMovies();

      // Verify the result is an empty list
      expect(result, equals([]));
      verify(() => mockBox.get(favoriteMoviesKey)).called(1);
    });

    test('removeFavoriteMovieById removes a movie by its ID', () {
      const movieIds = ['101', '102', '103'];
      const movieIdToRemove = 102;

      // Mock the Hive box to return a list of favorite movies
      when(() => mockBox.get(favoriteMoviesKey)).thenReturn(movieIds);

      // Call the removeFavoriteMovieById method
      movieLocalDatabase.removeFavoriteMovieById(movieIdToRemove);

      // Verify that the updated list without the removed movie ID was saved
      verify(() => mockBox.put(favoriteMoviesKey, ['101', '103'])).called(1);
    });
  });
}
