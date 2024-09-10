// Import necessary dependencies
import 'package:cinema_app/app/bloc/app_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChangeDisplayModeEvent', () {
    test('supports value comparisons', () {
      const displayMode1 = DisplayMode.list;
      const displayMode2 = DisplayMode.grid;

      expect(
        const ChangeDisplayModeEvent(displayMode1),
        const ChangeDisplayModeEvent(displayMode1),
      );

      expect(
        const ChangeDisplayModeEvent(displayMode1) ==
            const ChangeDisplayModeEvent(displayMode2),
        false,
      );
    });

    test('props are correct', () {
      const displayMode = DisplayMode.grid;
      expect(
        const ChangeDisplayModeEvent(displayMode).props,
        [displayMode],
      );
    });
  });

  group('ChangeTabEvent', () {
    test('supports value comparisons', () {
      expect(
        const ChangeTabEvent(index: 1),
        const ChangeTabEvent(index: 1),
      );

      expect(
        const ChangeTabEvent(index: 1) == const ChangeTabEvent(index: 2),
        false,
      );
    });

    test('props are correct', () {
      expect(
        const ChangeTabEvent(index: 2).props,
        [2],
      );
    });
  });
}
