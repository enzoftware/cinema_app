import 'package:cinema_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('CinemaAppBar Tests', () {
    testWidgets('renders CinemaAppBar with title and actions',
        (WidgetTester tester) async {
      // Arrange: Define the action buttons and title
      const testTitle = 'Popular Movies';
      final testActions = [
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
      ];

      // Act: Pump the widget with the extension
      await tester.pumpCinemaAppWithLocale(
        child: CustomScrollView(
          slivers: [
            CinemaAppBar(title: testTitle, actions: testActions),
          ],
        ),
      );

      // Assert: Check if the app bar is rendered correctly
      expect(find.text(testTitle), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('centers the title when collapsed',
        (WidgetTester tester) async {
      const testTitle = 'Popular Movies';

      // Act: Pump the widget and scroll to collapse the app bar
      await tester.pumpCinemaAppWithLocale(
        child: const CustomScrollView(
          slivers: [
            CinemaAppBar(title: testTitle),
            SliverToBoxAdapter(
              child: SizedBox(height: 1000), // To allow scrolling
            ),
          ],
        ),
      );

      // Before collapsing, the title should not be centered
      final textBeforeCollapse = tester.widget<Text>(find.text(testTitle));
      expect(textBeforeCollapse.style?.fontSize, 24);

      // Scroll to collapse the app bar
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // After collapsing, the title should be centered
      final textAfterCollapse = tester.widget<Text>(find.text(testTitle));
      expect(textAfterCollapse.style?.fontSize, 24);
    });

    testWidgets('title is aligned left when expanded',
        (WidgetTester tester) async {
      const testTitle = 'Popular Movies';

      // Act: Pump the widget without collapsing the app bar
      await tester.pumpCinemaAppWithLocale(
        child: const CustomScrollView(
          slivers: [
            CinemaAppBar(title: testTitle),
          ],
        ),
      );

      // Verify that the title is aligned to the left when the app bar expanded
      final titleFinder = find.text(testTitle);
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('title is centered when collapsed',
        (WidgetTester tester) async {
      const testTitle = 'Popular Movies';

      // Act: Pump the widget and scroll to collapse the app bar
      await tester.pumpCinemaAppWithLocale(
        child: const CustomScrollView(
          slivers: [
            CinemaAppBar(title: testTitle),
            SliverToBoxAdapter(
              child: SizedBox(height: 1000), // To allow scrolling
            ),
          ],
        ),
      );

      // Scroll to collapse the app bar
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Verify that the title is centered when the app bar is collapsed
      final titleFinder = find.text(testTitle);
      expect(titleFinder, findsOneWidget);
    });
  });
}
