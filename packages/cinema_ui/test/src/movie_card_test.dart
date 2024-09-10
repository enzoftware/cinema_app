import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  const movieTitle = 'Movie Title';
  const releaseDate = '2024-06-20';
  const posterPath = '/path/to/poster.jpg';

  group('MovieCard', () {
    testWidgets(
      'renders a list MovieCard with correct data',
      (WidgetTester tester) async {
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MovieCard.list(
                  title: movieTitle,
                  releaseDate: releaseDate,
                  poster: posterPath,
                ),
              ),
            ),
          );

          expect(find.text(movieTitle), findsOneWidget);
          expect(find.text(releaseDate), findsOneWidget);
          expect(find.byType(FavoriteIcon), findsOneWidget);
          expect(find.byType(TMDBImage), findsOneWidget);
        });
      },
    );

    testWidgets(
      'renders a grid MovieCard with correct data',
      (WidgetTester tester) async {
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MovieCard.grid(
                  title: movieTitle,
                  releaseDate: releaseDate,
                  poster: posterPath,
                ),
              ),
            ),
          );

          expect(find.text(movieTitle), findsOneWidget);
          expect(find.text(releaseDate), findsOneWidget);
          expect(find.byType(FavoriteIcon), findsOneWidget);
          expect(find.byType(TMDBImage), findsOneWidget);
        });
      },
    );

    testWidgets(
      'calls onFavoriteTap when favorite icon is tapped (list view)',
      (WidgetTester tester) async {
        var wasFavoriteTapped = false;

        await mockNetworkImages(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MovieCard.list(
                  title: movieTitle,
                  releaseDate: releaseDate,
                  poster: posterPath,
                  onFavoriteTap: () => wasFavoriteTapped = true,
                ),
              ),
            ),
          );

          await tester.tap(find.byType(FavoriteIcon));
          await tester.pumpAndSettle();

          expect(wasFavoriteTapped, isTrue);
        });
      },
    );

    testWidgets(
      'calls onFavoriteTap when favorite icon is tapped (grid view)',
      (WidgetTester tester) async {
        var wasFavoriteTapped = false;

        await mockNetworkImages(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MovieCard.grid(
                  title: movieTitle,
                  releaseDate: releaseDate,
                  poster: posterPath,
                  onFavoriteTap: () => wasFavoriteTapped = true,
                ),
              ),
            ),
          );

          await tester.tap(find.byType(FavoriteIcon));
          await tester.pumpAndSettle();

          expect(wasFavoriteTapped, isTrue);
        });
      },
    );

    testWidgets(
      'displays filled heart icon when isFavorite is true',
      (WidgetTester tester) async {
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MovieCard.list(
                  title: movieTitle,
                  releaseDate: releaseDate,
                  poster: posterPath,
                  isFavorite: true,
                ),
              ),
            ),
          );

          final icon = tester.widget<Icon>(find.byType(Icon));
          expect(icon.icon, equals(Icons.favorite));
        });
      },
    );

    testWidgets(
      'displays outlined heart icon when isFavorite is false',
      (WidgetTester tester) async {
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: MovieCard.grid(
                  title: movieTitle,
                  releaseDate: releaseDate,
                  poster: posterPath,
                ),
              ),
            ),
          );

          final icon = tester.widget<Icon>(find.byType(Icon));
          expect(icon.icon, equals(Icons.favorite_border_outlined));
        });
      },
    );
  });
}
