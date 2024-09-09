import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('MovieCard Widget Tests', () {
    testWidgets('renders correctly in list mode', (WidgetTester tester) async {
      // Build the MovieCard in list mode
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard.list(
              title: 'Inception',
              releaseDate: '2010-07-16',
              poster: '/inception.jpg',
              popularity: 9.8,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify ListTile is used and renders correctly
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text('Inception'), findsOneWidget);
      expect(find.text('2010-07-16'), findsOneWidget);
      expect(
        find.text('9.8'),
        findsNothing,
      ); // Popularity is not displayed in ListTile
    });

    testWidgets('renders correctly in grid mode', (WidgetTester tester) async {
      // Build the MovieCard in grid mode
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard.grid(
              title: 'Interstellar',
              releaseDate: '2014-11-07',
              poster: '/interstellar.jpg',
              popularity: 9.5,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify GridTile is used and renders correctly
      expect(find.byType(GridTile), findsOneWidget);
      expect(find.text('Interstellar'), findsOneWidget);
      expect(find.text('2014-11-07'), findsOneWidget);
      expect(
        find.text('9.5'),
        findsOneWidget,
      ); // Popularity is displayed in GridTile
    });

    testWidgets('triggers onTap when tapped in list mode',
        (WidgetTester tester) async {
      // Create a mock callback for onTap
      final mockOnTap = MockFunction();

      // Build the MovieCard in list mode
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard.list(
              title: 'Inception',
              releaseDate: '2010-07-16',
              poster: '/inception.jpg',
              popularity: 9.8,
              onTap: mockOnTap.call, // Pass the mock callback
            ),
          ),
        ),
      );

      // Tap the ListTile and verify onTap is triggered
      await tester.tap(find.byType(ListTile));
      verify(mockOnTap.call).called(1);
    });

    testWidgets('triggers onTap when tapped in grid mode',
        (WidgetTester tester) async {
      // Create a mock callback for onTap
      final mockOnTap = MockFunction();

      // Build the MovieCard in grid mode
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard.grid(
              title: 'Interstellar',
              releaseDate: '2014-11-07',
              poster: '/interstellar.jpg',
              popularity: 9.5,
              onTap: mockOnTap.call, // Pass the mock callback
            ),
          ),
        ),
      );

      // Tap the GridTile and verify onTap is triggered
      await tester.tap(find.byType(GridTile));
      verify(mockOnTap.call).called(1);
    });

    testWidgets('renders poster image correctly in list mode',
        (WidgetTester tester) async {
      // Build the MovieCard in list mode with a mock image
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard.list(
              title: 'Inception',
              releaseDate: '2010-07-16',
              poster: '/inception.jpg',
              popularity: 9.8,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify the poster image is rendered
      expect(find.byType(TMDBImage), findsOneWidget);
    });

    testWidgets('renders poster image correctly in grid mode',
        (WidgetTester tester) async {
      // Build the MovieCard in grid mode with a mock image
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard.grid(
              title: 'Interstellar',
              releaseDate: '2014-11-07',
              poster: '/interstellar.jpg',
              popularity: 9.5,
              onTap: () {},
            ),
          ),
        ),
      );

      // Verify the poster image is rendered
      expect(find.byType(TMDBImage), findsOneWidget);
    });
  });
}

// Mock class to simulate a VoidCallback
class MockFunction extends Mock {
  void call();
}
