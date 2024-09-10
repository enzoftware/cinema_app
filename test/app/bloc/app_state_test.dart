import 'package:cinema_app/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DisplayModeExtension', () {
    test('toggle switches between list and grid', () {
      expect(DisplayMode.list.toggle(), DisplayMode.grid);
      expect(DisplayMode.grid.toggle(), DisplayMode.list);
    });
  });

  group('AppStateExtension', () {
    test('view returns HomeAppView.popular for selectedIndex 0', () {
      const appState = AppState();
      expect(appState.view(), HomeAppView.popular);
    });

    test('view returns HomeAppView.nowPlaying for selectedIndex other than 0',
        () {
      const appState = AppState(selectedIndex: 1);
      expect(appState.view(), HomeAppView.nowPlaying);
    });
  });

  group('AppState', () {
    test('supports value comparisons', () {
      expect(
        const AppState(),
        const AppState(),
      );

      expect(
        const AppState(selectedIndex: 1, displayMode: DisplayMode.grid),
        const AppState(selectedIndex: 1, displayMode: DisplayMode.grid),
      );

      expect(
        const AppState(selectedIndex: 1),
        isNot(const AppState()),
      );
    });

    test('props are correct', () {
      const appState =
          AppState(selectedIndex: 1, displayMode: DisplayMode.grid);
      expect(appState.props, [1, DisplayMode.grid]);
    });

    test('copyWith creates a copy with updated values', () {
      const appState = AppState();

      // Copy with no updates
      expect(appState.copyWith(), appState);

      // Copy with updated selectedIndex
      expect(
        appState.copyWith(selectedIndex: 1),
        const AppState(selectedIndex: 1),
      );

      // Copy with updated displayMode
      expect(
        appState.copyWith(displayMode: DisplayMode.grid),
        const AppState(displayMode: DisplayMode.grid),
      );

      // Copy with both updated
      expect(
        appState.copyWith(selectedIndex: 1, displayMode: DisplayMode.grid),
        const AppState(selectedIndex: 1, displayMode: DisplayMode.grid),
      );
    });
  });
}
