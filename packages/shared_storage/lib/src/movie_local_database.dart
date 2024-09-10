import 'package:hive/hive.dart';

/// {@template movie_local_database}
/// A class that provides local storage functionality for favorite movies
/// using Hive.
///
/// This class allows users to add, retrieve, and remove favorite movies by
/// interacting with the underlying Hive storage system.
/// {@endtemplate}
class MovieLocalDatabase {
  /// {@macro movie_local_database}
  ///
  /// Constructs a [MovieLocalDatabase] with a provided Hive [Box].
  ///
  /// - [favoriteMovies]: The Hive box that stores the list of favorite movie
  /// IDs.
  MovieLocalDatabase(Box<List<String>> favoriteMovies)
      : favoriteMoviesBox = favoriteMovies;

  /// The Hive box that stores a list of favorite movie IDs.
  final Box<List<String>> favoriteMoviesBox;

  /// The name of the Hive box that stores the list of favorite movies.
  ///
  /// This constant is used to open or reference the Hive box.
  static const boxName = 'favoriteMoviesBox';

  /// The key used to store and retrieve favorite movie IDs in the Hive box.
  static const favoriteMoviesKey = 'favorite_movies';

  /// {@template add_favorite_movie}
  /// Adds a new movie to the list of favorite movies.
  ///
  /// - [newMovieId]: The ID of the movie to be added to the favorite movies
  /// list.
  ///
  /// The updated list of favorite movies is saved back to the Hive box.
  /// {@endtemplate}
  void addFavoriteMovie(String newMovieId) {
    final currentMoviesIds = getFavoriteMovies()..add(newMovieId);

    // Save the updated list back to Hive
    favoriteMoviesBox.put(favoriteMoviesKey, currentMoviesIds);
  }

  /// {@template get_favorite_movies}
  /// Retrieves the list of favorite movies from the Hive box.
  ///
  /// Returns a list of movie IDs. If there are no favorite movies stored,
  /// returns an empty list.
  /// {@endtemplate}
  List<String> getFavoriteMovies() => List<String>.from(
        favoriteMoviesBox.get(favoriteMoviesKey) ?? [],
      );

  /// {@template remove_favorite_movie_by_id}
  /// Removes a movie from the favorite movies list by its ID.
  ///
  /// - [id]: The ID of the movie to be removed from the favorite movies list.
  ///
  /// The updated list of favorite movies is saved back to the Hive box.
  /// {@endtemplate}
  void removeFavoriteMovieById(int id) {
    final currentMovies = getFavoriteMovies();
    final index = currentMovies.indexOf(id.toString());
    currentMovies.removeAt(index);
    favoriteMoviesBox.put(favoriteMoviesKey, currentMovies);
  }
}
