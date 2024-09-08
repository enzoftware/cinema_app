import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';

/// {@template movie_card}
/// A reusable UI component for displaying movie information.
/// It can either be displayed as a list item or as a grid item depending
/// on the display mode. The card includes a movie poster, title, release date,
/// and popularity score.
/// {@endtemplate}
class MovieCard extends StatelessWidget {
  /// {@macro movie_card}
  ///
  /// Factory constructor to create a ListView-style [MovieCard].
  ///
  /// Displays the movie in a list item layout.
  ///
  /// - [title] is the name of the movie.
  /// - [releaseDate] is the date the movie was released.
  /// - [poster] is the path to the movie poster image.
  /// - [popularity] is the movie's popularity score.
  /// - [onTap] is an optional callback function triggered when the card is
  /// tapped.
  factory MovieCard.list({
    required String title,
    required String releaseDate,
    required String poster,
    required double popularity,
    VoidCallback? onTap,
    Key? key,
  }) {
    return MovieCard._(
      title: title,
      releaseDate: releaseDate,
      poster: poster,
      popularity: popularity,
      onTap: onTap,
      isGrid: false, // Indicate this is for the list view
      key: key,
    );
  }

  /// {@macro movie_card}
  ///
  /// Factory constructor to create a GridView-style [MovieCard].
  ///
  /// Displays the movie in a grid item layout.
  ///
  /// - [title] is the name of the movie.
  /// - [releaseDate] is the date the movie was released.
  /// - [poster] is the path to the movie poster image.
  /// - [popularity] is the movie's popularity score.
  /// - [onTap] is an optional callback function triggered when the card is
  /// tapped.
  factory MovieCard.grid({
    required String title,
    required String releaseDate,
    required String poster,
    required double popularity,
    VoidCallback? onTap,
    Key? key,
  }) {
    return MovieCard._(
      title: title,
      releaseDate: releaseDate,
      poster: poster,
      popularity: popularity,
      onTap: onTap,
      isGrid: true,
      key: key,
    );
  }

  /// Private constructor for [MovieCard].
  ///
  /// This constructor is used internally by the factory constructors
  /// to create either a list or grid version of the card.
  const MovieCard._({
    required this.title,
    required this.releaseDate,
    required this.poster,
    required this.popularity,
    required this.isGrid,
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

  /// An optional callback function that is triggered when the card is tapped.
  final VoidCallback? onTap;

  /// Whether the card is being displayed in grid mode or list mode.
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    // Use the isGrid flag to switch between ListTile and GridTile layout
    return isGrid
        ? GestureDetector(
            onTap: onTap,
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(title),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(releaseDate),
                    Text('$popularity'),
                  ],
                ),
              ),
              child: TMDBImage(width: 150, height: 225, path: poster),
            ),
          )
        : ListTile(
            onTap: onTap,
            leading: SizedBox(
              width: 75,
              height: 75,
              child: TMDBImage(width: 75, height: 75, path: poster),
            ),
            title: Text(title),
            subtitle: Text(releaseDate),
          );
  }
}
