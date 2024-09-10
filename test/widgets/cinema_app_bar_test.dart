import 'package:cinema_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('CinemaAppBar Tests', () {
    testWidgets('renders CinemaAppBar with title and actions',
        (WidgetTester tester) async {
      const testTitle = 'Popular Movies';
      final testActions = [
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
      ];

      await tester.pumpCinemaAppWithLocale(
        child: CustomScrollView(
          slivers: [
            CinemaAppBar(title: testTitle, actions: testActions),
          ],
        ),
      );

      expect(find.text(testTitle), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('centers the title when collapsed',
        (WidgetTester tester) async {
      const testTitle = 'Popular Movies';

      await tester.pumpCinemaAppWithLocale(
        child: const CustomScrollView(
          slivers: [
            CinemaAppBar(title: testTitle),
            SliverToBoxAdapter(
              child: SizedBox(height: 1000),
            ),
          ],
        ),
      );

      final textBeforeCollapse = tester.widget<Text>(find.text(testTitle));
      expect(textBeforeCollapse.style?.fontSize, 24);

      await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      final textAfterCollapse = tester.widget<Text>(find.text(testTitle));
      expect(textAfterCollapse.style?.fontSize, 24);
    });

    testWidgets('title is aligned left when expanded',
        (WidgetTester tester) async {
      const testTitle = 'Popular Movies';

      await tester.pumpCinemaAppWithLocale(
        child: const CustomScrollView(
          slivers: [
            CinemaAppBar(title: testTitle),
          ],
        ),
      );

      final titleFinder = find.text(testTitle);
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('title is centered when collapsed',
        (WidgetTester tester) async {
      const testTitle = 'Popular Movies';

      await tester.pumpCinemaAppWithLocale(
        child: const CustomScrollView(
          slivers: [
            CinemaAppBar(title: testTitle),
            SliverToBoxAdapter(
              child: SizedBox(height: 1000),
            ),
          ],
        ),
      );

      await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      final titleFinder = find.text(testTitle);
      expect(titleFinder, findsOneWidget);
    });
  });
}
