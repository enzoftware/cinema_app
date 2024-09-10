import 'package:bloc_test/bloc_test.dart';
import 'package:cinema_app/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_storage/shared_storage.dart';

class MockSharedStorage extends Mock implements SharedStorage {}

void main() {
  late SharedStorage mockStorage;

  setUp(() {
    mockStorage = MockSharedStorage();
    when(() => mockStorage.readString(key: any(named: 'key')))
        .thenReturn(DisplayMode.list.name);
    when(
      () => mockStorage.writeString(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  });

  group('AppBloc', () {
    blocTest<AppBloc, AppState>(
      'emits updated state when ChangeTabEvent is added',
      build: () => AppBloc(mockStorage),
      act: (bloc) => bloc.add(const ChangeTabEvent(index: 1)),
      expect: () => [
        const AppState(),
        const AppState(selectedIndex: 1),
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits updated state when ChangeDisplayModeEvent is added',
      build: () => AppBloc(mockStorage),
      act: (bloc) => bloc.add(const ChangeDisplayModeEvent(DisplayMode.grid)),
      expect: () => [
        const AppState(),
        const AppState(displayMode: DisplayMode.grid),
      ],
      verify: (_) {
        verify(
          () => mockStorage.writeString(
            key: 'displayMode',
            value: DisplayMode.grid.name,
          ),
        ).called(1);
      },
    );

    blocTest<AppBloc, AppState>(
      'initializes with display mode from storage if available',
      setUp: () {
        when(() => mockStorage.readString(key: 'displayMode'))
            .thenReturn(DisplayMode.grid.name);
      },
      build: () => AppBloc(mockStorage),
      expect: () => [const AppState(displayMode: DisplayMode.grid)],
      verify: (_) {
        verify(() => mockStorage.readString(key: 'displayMode')).called(1);
      },
    );

    blocTest<AppBloc, AppState>(
      'does not change state when displayMode is empty in storage',
      setUp: () {
        when(() => mockStorage.readString(key: 'displayMode')).thenReturn('');
      },
      build: () => AppBloc(mockStorage),
      expect: () => const <AppState>[],
      verify: (_) {
        verify(() => mockStorage.readString(key: 'displayMode')).called(1);
      },
    );
  });
}
