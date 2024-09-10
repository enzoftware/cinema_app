import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';

/// {@template movie_card}
/// A reusable UI component for displaying movie information, either in a
/// list or grid view.
///
/// The [MovieCard] widget includes the movie's poster, title, release date,
/// and a favorite toggle. The card layout adjusts depending on whether it is
/// displayed in a list or grid mode, making it versatile for different UI
/// display options. The user can tap the favorite icon to mark a movie as
/// a favorite.
/// {@endtemplate}
class MovieCard extends StatelessWidget {
  /// {@macro movie_card}
  ///
  /// Factory constructor to create a ListView-style [MovieCard].
  ///
  /// This version of the card is laid out for a list view, typically used when
  /// presenting movie data in a vertical list format.
  ///
  /// - [title]: The name of the movie.
  /// - [releaseDate]: The release date of the movie.
  /// - [poster]: The path to the movie poster image.
  /// - [onFavoriteTap]: A callback that triggers when the favorite icon is
  /// tapped.
  /// - [isFavorite]: Indicates whether the movie is marked as a favorite.
  factory MovieCard.list({
    required String title,
    required String releaseDate,
    required String poster,
    VoidCallback? onFavoriteTap,
    bool isFavorite = false,
    Key? key,
  }) {
    return MovieCard._(
      title: title,
      releaseDate: releaseDate,
      poster: poster,
      isGrid: false,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      key: key,
    );
  }

  /// {@macro movie_card}
  ///
  /// Factory constructor to create a GridView-style [MovieCard].
  ///
  /// This version of the card is laid out for a grid view, commonly used when
  /// displaying movies in a grid format where multiple movie cards are shown
  /// side by side.
  ///
  /// - [title]: The name of the movie.
  /// - [releaseDate]: The release date of the movie.
  /// - [poster]: The path to the movie poster image.
  /// - [onFavoriteTap]: A callback that triggers when the favorite icon is
  /// tapped.
  /// - [isFavorite]: Indicates whether the movie is marked as a favorite.
  factory MovieCard.grid({
    required String title,
    required String releaseDate,
    required String poster,
    VoidCallback? onFavoriteTap,
    bool isFavorite = false,
    Key? key,
  }) {
    return MovieCard._(
      title: title,
      releaseDate: releaseDate,
      poster: poster,
      isGrid: true,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      key: key,
    );
  }

  /// Private constructor used internally by both the list and grid factory
  /// constructors.
  ///
  /// This constructor accepts common arguments required to build the movie
  /// card, regardless of whether it's for a list or grid view.
  const MovieCard._({
    required this.title,
    required this.releaseDate,
    required this.poster,
    required this.isGrid,
    this.isFavorite = false,
    this.onFavoriteTap,
    super.key,
  });

  /// The title of the movie being displayed.
  final String title;

  /// The release date of the movie being displayed.
  final String releaseDate;

  /// The path to the movie poster image from TheMovieDB.
  final String poster;

  /// Determines whether the card is being displayed in grid mode or list mode.
  final bool isGrid;

  /// Indicates whether the movie is currently marked as a favorite.
  final bool isFavorite;

  /// A callback function that is triggered when the favorite icon is tapped.
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    // The layout is determined by the `isGrid` flag.
    return isGrid
        ? GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.white,
              trailing: GestureDetector(
                onTap: onFavoriteTap,
                child: FavoriteIcon(isFavorite: isFavorite),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                releaseDate,
                style: const TextStyle(color: Colors.black, fontSize: 8),
              ),
            ),
            child: TMDBImage(width: 150, height: 225, path: poster),
          )
        : ListTile(
            leading: SizedBox(
              width: 75,
              height: 75,
              child: TMDBImage(width: 75, height: 75, path: poster),
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: GestureDetector(
              onTap: onFavoriteTap,
              child: FavoriteIcon(isFavorite: isFavorite),
            ),
            subtitle: Text(
              releaseDate,
              style: const TextStyle(color: Colors.black, fontSize: 8),
            ),
          );
  }
}

/// A reusable widget that displays a heart-shaped icon indicating whether
/// a movie is marked as a favorite.
///
/// - [isFavorite]: Determines if the heart icon is filled (indicating
/// a favorite) or outlined (indicating not a favorite).
class FavoriteIcon extends StatelessWidget {
  /// Creates a [FavoriteIcon] widget to represent the favorite status of
  /// a movie.
  ///
  /// - [isFavorite]: If true, shows a filled heart icon. If false, shows
  /// an outlined heart icon.
  const FavoriteIcon({
    required this.isFavorite,
    super.key,
  });

  /// Indicates whether the movie is a favorite. A filled heart is shown
  /// when true, and an outlined heart is shown when false.
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
      color: Colors.red,
    );
  }
}
