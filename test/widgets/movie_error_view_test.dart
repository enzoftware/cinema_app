import 'package:cinema_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  group('MovieErrorView Widget Tests', () {
    testWidgets('displays the error message', (WidgetTester tester) async {
      const errorMessage = 'An error occurred';

      await tester.pumpCinemaAppWithLocale(
        child: const CustomScrollView(
          slivers: [
            MovieErrorView(message: errorMessage),
          ],
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('displays the error image', (WidgetTester tester) async {
      const errorMessage = 'An error occurred';

      await tester.pumpCinemaAppWithLocale(
        child: const CustomScrollView(
          slivers: [
            MovieErrorView(message: errorMessage),
          ],
        ),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
    });
  });
}
