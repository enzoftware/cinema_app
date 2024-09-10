import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/widgets/widgets.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import '../helpers/helpers.dart';

void main() {
  group('MovieResultListView Tests', () {
    late List<MovieResult> movies;
    late List<String> favoriteMovies;
    late void Function(int index, {bool isFavorite}) onFavoriteMovieTapped;

    setUp(() {
      movies = List.generate(
        10,
        (index) => MovieResult(
          id: index,
          title: 'Movie $index',
          posterPath: '/path/to/poster$index.jpg',
          popularity: 5.0 + index,
          releaseDate: DateTime(2022, 5, 12),
        ),
      );
      favoriteMovies = ['1', '3'];
      onFavoriteMovieTapped = (index, {bool isFavorite = false}) {};
    });

    testWidgets('renders list view with correct number of movies',
        (WidgetTester tester) async {
      // Arrange
      const displayMode = DisplayMode.list;

      // Act
      await mockNetworkImages(() async {
        await tester.pumpCinemaAppWithLocale(
          child: CustomScrollView(
            slivers: [
              MovieResultListView(
                displayMode: displayMode,
                movies: movies,
                favoriteMovies: favoriteMovies,
                onFavoriteMovieTapped: onFavoriteMovieTapped,
              ),
            ],
          ),
        );

        await tester.pumpAndSettle();
      });

      // Assert
      expect(find.byType(MovieCard), findsAtLeast(6));
    });

    testWidgets('renders grid view with correct number of movies',
        (WidgetTester tester) async {
      // Arrange
      const displayMode = DisplayMode.grid;

      // Act
      await mockNetworkImages(() async {
        await tester.pumpCinemaAppWithLocale(
          child: CustomScrollView(
            slivers: [
              MovieResultListView(
                displayMode: displayMode,
                movies: movies,
                favoriteMovies: favoriteMovies,
                onFavoriteMovieTapped: onFavoriteMovieTapped,
              ),
            ],
          ),
        );
        await tester.pumpAndSettle();

        // Scroll to make sure all elements are visible
        await tester.drag(find.byType(Scrollable), const Offset(0, -1000));
        await tester.pumpAndSettle();
      });

      // Assert
      expect(find.byType(MovieCard), findsAtLeast(4));
    });

    testWidgets('calls onFavoriteMovieTapped when favorite icon is tapped',
        (WidgetTester tester) async {
      // Arrange
      const displayMode = DisplayMode.list;
      var tappedIndex = -1;
      var isFavoriteStatus = false;

      onFavoriteMovieTapped = (index, {bool isFavorite = false}) {
        tappedIndex = index;
        isFavoriteStatus = isFavorite;
      };

      // Act
      await mockNetworkImages(() async {
        await tester.pumpCinemaAppWithLocale(
          child: CustomScrollView(
            slivers: [
              MovieResultListView(
                displayMode: displayMode,
                movies: movies,
                favoriteMovies: favoriteMovies,
                onFavoriteMovieTapped: onFavoriteMovieTapped,
              ),
            ],
          ),
        );
      });

      // Simulate tapping on the favorite icon for the first movie
      final favoriteIcon = find.byIcon(Icons.favorite_border_outlined).first;
      await tester.tap(favoriteIcon);
      await tester.pump();

      // Assert
      expect(tappedIndex, 0); // First movie was tapped
      expect(isFavoriteStatus, false); // First movie is not favorite
    });

    testWidgets('displays the correct favorite status for each movie',
        (WidgetTester tester) async {
      // Arrange
      const displayMode = DisplayMode.list;

      // Act
      await mockNetworkImages(() async {
        await tester.pumpCinemaAppWithLocale(
          child: CustomScrollView(
            slivers: [
              MovieResultListView(
                displayMode: displayMode,
                movies: movies,
                favoriteMovies: favoriteMovies,
                onFavoriteMovieTapped: onFavoriteMovieTapped,
              ),
            ],
          ),
        );
      });

      final favoriteIconFinder = find.byIcon(Icons.favorite);
      expect(favoriteIconFinder, findsNWidgets(2));

      final notFavoriteIconFinder = find.byIcon(Icons.favorite_border_outlined);
      expect(
        notFavoriteIconFinder,
        findsNWidgets(7),
      );
    });
  });
}
