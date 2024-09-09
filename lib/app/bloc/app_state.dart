part of 'app_bloc.dart';

enum DisplayMode { list, grid }

enum HomeAppView { popular, nowPlaying }

extension DisplayModeExtension on DisplayMode {
  /// Returns the opposite display mode.
  DisplayMode toggle() {
    return this == DisplayMode.list ? DisplayMode.grid : DisplayMode.list;
  }
}

extension AppStateExtension on AppState {
  /// Returns the opposite display mode.
  HomeAppView view() {
    return selectedIndex == 0 ? HomeAppView.popular : HomeAppView.nowPlaying;
  }
}

class AppState extends Equatable {
  const AppState({this.selectedIndex = 0, this.displayMode = DisplayMode.list});

  final int selectedIndex;
  final DisplayMode displayMode;

  /// Creates a copy of the current AppState instance with the option
  /// to override selectedIndex and displayMode with new values.
  ///
  /// Example usage:
  /// ```dart
  /// final newState = currentState.copyWith(selectedIndex: 1);
  /// ```
  AppState copyWith({
    int? selectedIndex,
    DisplayMode? displayMode,
  }) {
    return AppState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      displayMode: displayMode ?? this.displayMode,
    );
  }

  @override
  List<Object> get props => [selectedIndex, displayMode];
}
