import 'package:cinema_app/app/app.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';

class MovieResultListView extends StatelessWidget {
  const MovieResultListView({
    required this.displayMode,
    required this.movies,
    required this.onFavoriteMovieTapped,
    required this.favoriteMovies,
    super.key,
  });

  final DisplayMode displayMode;
  final List<MovieResult> movies;
  final List<String> favoriteMovies;
  final void Function(int index, {bool isFavorite}) onFavoriteMovieTapped;

  @override
  Widget build(BuildContext context) {
    return displayMode == DisplayMode.list
        ? SliverList.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final isFavorite = favoriteMovies.contains(movie.id.toString());
              return MovieCard.list(
                key: Key('${movie.id}'),
                title: movie.title ?? '',
                releaseDate: movie.formattedReleaseDate,
                poster: movie.posterPath ?? '',
                onFavoriteTap: () =>
                    onFavoriteMovieTapped(index, isFavorite: isFavorite),
                isFavorite: isFavorite,
              );
            },
          )
        : SliverGrid.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final isFavorite = favoriteMovies.contains(movie.id.toString());
              return MovieCard.grid(
                key: Key('${movie.id}'),
                title: movie.title ?? '',
                releaseDate: movie.formattedReleaseDate,
                poster: movie.posterPath ?? '',
                onFavoriteTap: () =>
                    onFavoriteMovieTapped(index, isFavorite: isFavorite),
                isFavorite: isFavorite,
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
          );
  }
}
