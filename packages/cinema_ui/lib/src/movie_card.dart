import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';

/// {@template movie_card}
/// A reusable UI component for displaying movie information in a list or grid
/// view.
///
/// The card includes a movie poster, title, release date, popularity score,
/// and a favorite toggle. The layout of the card changes based on the view mode
/// (list or grid).
/// {@endtemplate}
class MovieCard extends StatelessWidget {
  /// {@macro movie_card}
  ///
  /// Factory constructor to create a ListView-style [MovieCard].
  ///
  /// Displays the movie in a list item layout.
  ///
  /// - [title]: The name of the movie.
  /// - [releaseDate]: The date the movie was released.
  /// - [poster]: The path to the movie poster image.
  /// - [popularity]: The movie's popularity score.
  /// - [onTap]: Optional callback function triggered when the card is tapped.
  /// - [onFavoriteTap]: Optional callback for when the favorite icon is tapped.
  /// - [isFavorite]: Indicates whether the movie is marked as a favorite.
  factory MovieCard.list({
    required String title,
    required String releaseDate,
    required String poster,
    required double popularity,
    VoidCallback? onTap,
    VoidCallback? onFavoriteTap,
    bool isFavorite = false,
    Key? key,
  }) {
    return MovieCard._(
      title: title,
      releaseDate: releaseDate,
      poster: poster,
      popularity: popularity,
      onTap: onTap,
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
  /// Displays the movie in a grid item layout.
  ///
  /// - [title]: The name of the movie.
  /// - [releaseDate]: The date the movie was released.
  /// - [poster]: The path to the movie poster image.
  /// - [popularity]: The movie's popularity score.
  /// - [onTap]: Optional callback function triggered when the card is tapped.
  /// - [onFavoriteTap]: Optional callback for when the favorite icon is tapped.
  /// - [isFavorite]: Indicates whether the movie is marked as a favorite.
  factory MovieCard.grid({
    required String title,
    required String releaseDate,
    required String poster,
    required double popularity,
    VoidCallback? onTap,
    VoidCallback? onFavoriteTap,
    bool isFavorite = false,
    Key? key,
  }) {
    return MovieCard._(
      title: title,
      releaseDate: releaseDate,
      poster: poster,
      popularity: popularity,
      onTap: onTap,
      isGrid: true,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      key: key,
    );
  }

  /// Private constructor for [MovieCard].
  ///
  /// This constructor is used internally by the factory constructors to
  /// create either a list or grid version of the card.
  const MovieCard._({
    required this.title,
    required this.releaseDate,
    required this.poster,
    required this.popularity,
    required this.isGrid,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onTap,
    super.key,
  });

  /// The title of the movie.
  final String title;

  /// The release date of the movie.
  final String releaseDate;

  /// The path to the movie poster image.
  final String poster;

  /// The popularity score of the movie.
  final double popularity;

  /// Callback triggered when the card is tapped.
  final VoidCallback? onTap;

  /// Determines whether the card is displayed in grid mode or list mode.
  final bool isGrid;

  /// Indicates whether the movie is marked as a favorite.
  final bool isFavorite;

  /// Callback triggered when the favorite icon is tapped.
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    // Use the isGrid flag to switch between ListTile and GridTile layout
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

/// A widget that displays a heart icon to represent whether a movie
/// is marked as a favorite.
///
/// - [isFavorite]: Determines if the heart is filled (favorite) or outlined.
class FavoriteIcon extends StatelessWidget {
  /// Creates a [FavoriteIcon] widget to display the favorite state of a movie.
  ///
  /// - [isFavorite]: If true, shows a filled heart icon. If false, shows an
  /// outlined heart icon.
  const FavoriteIcon({
    required this.isFavorite,
    super.key,
  });

  /// Whether the movie is a favorite.
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
      color: Colors.red,
    );
  }
}
