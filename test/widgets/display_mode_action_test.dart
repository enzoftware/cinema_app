import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  group('DisplayModeAction', () {
    testWidgets('renders ${const Icon(Icons.grid_on)} when displayMode is list',
        (WidgetTester tester) async {
      await tester.pumpCinemaAppWithLocale(
        child: const DisplayModeAction(
          displayMode: DisplayMode.list,
        ),
      );

      expect(find.byIcon(Icons.grid_on), findsOneWidget);
      expect(find.byIcon(Icons.list), findsNothing);
    });

    testWidgets('renders Icon(Icons.list) when displayMode is grid',
        (WidgetTester tester) async {
      await tester.pumpCinemaAppWithLocale(
        child: const DisplayModeAction(
          displayMode: DisplayMode.grid,
        ),
      );

      expect(find.byIcon(Icons.list), findsOneWidget);
      expect(find.byIcon(Icons.grid_on), findsNothing);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      var tapped = false;
      await tester.pumpCinemaAppWithLocale(
        child: DisplayModeAction(
          displayMode: DisplayMode.list,
          onTap: () {
            tapped = true;
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(tapped, true);
    });
  });
}
