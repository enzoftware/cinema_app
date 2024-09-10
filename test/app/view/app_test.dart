import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:cinema_app/popular_movies/popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late MockSharedStorage mockSharedStorage;
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockNowMoviesBloc mockNowMoviesBloc;
  late MockAppBloc mockAppBloc;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockSharedStorage = MockSharedStorage();
    mockPopularMoviesBloc = MockPopularMoviesBloc();
    mockNowMoviesBloc = MockNowMoviesBloc();
    mockAppBloc = MockAppBloc();

    when(() => mockSharedStorage.readString(key: any(named: 'key')))
        .thenReturn('value');
    when(
      () => mockSharedStorage.writeString(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((invocation) async {
      return;
    });
    when(() => mockAppBloc.storage).thenReturn(mockSharedStorage);
    when(() => mockPopularMoviesBloc.state)
        .thenReturn(PopularMoviesInitialLoading());
    when(() => mockNowMoviesBloc.state).thenReturn(NowMoviesInitialLoading());
    when(() => mockAppBloc.state).thenReturn(const AppState());
  });

  testWidgets('renders CinemaMovieApp', (tester) async {
    await tester.pumpWidget(
      CinemaMovieApp(
        movieRepository: mockMovieRepository,
        sharedStorage: mockSharedStorage,
      ),
    );

    expect(find.byType(CinemaMovieHome), findsOneWidget);
  });

  group('CinemaMovieHome Locale Tests', () {
    testWidgets('CinemaMovieHome renders and uses localization (English)',
        (WidgetTester tester) async {
      await tester.pumpWidgetWithLocale(
        mockAppBloc: mockAppBloc,
        mockPopularMoviesBloc: mockPopularMoviesBloc,
        child: const CinemaMovieHome(),
      );

      // Verify that the correct localized text is displayed
      expect(find.text('Popular Movies'), findsNWidgets(2));
    });

    testWidgets('CinemaMovieHome renders and uses localization (Spanish)',
        (WidgetTester tester) async {
      await tester.pumpWidgetWithLocale(
        locale: const Locale('es'),
        mockPopularMoviesBloc: mockPopularMoviesBloc,
        mockAppBloc: mockAppBloc,
        child: const CinemaMovieHome(),
      );

      // Verify that the correct localized text is displayed in Spanish
      expect(find.text('Películas Populares'), findsNWidgets(2));
    });
  });

  group('CinemaMovieApp', () {
    testWidgets('renders correctly with all providers', (tester) async {
      await tester.pumpWidgetWithLocale(
        child: CinemaMovieApp(
          movieRepository: mockMovieRepository,
          sharedStorage: mockSharedStorage,
        ),
      );

      expect(find.byType(CinemaMovieHome), findsOneWidget);
    });
  });

  group('CinemaMovieHome', () {
    testWidgets('renders PopularMoviesPage initially', (tester) async {
      await tester.pumpWidgetWithLocale(
        mockAppBloc: mockAppBloc,
        mockPopularMoviesBloc: mockPopularMoviesBloc,
        mockNowMoviesBloc: mockNowMoviesBloc,
        child: const CinemaMovieHome(),
      );

      expect(find.byType(PopularMoviesPage), findsOneWidget);
      expect(find.byType(NowPlayingPage), findsNothing);
    });

    testWidgets('renders NowPlayingPage when selectedIndex is 1',
        (tester) async {
      when(() => mockAppBloc.state)
          .thenReturn(const AppState(selectedIndex: 1));

      when(() => mockNowMoviesBloc.state).thenReturn(
        const NowMoviesDataLoaded(movies: []),
      );

      await tester.pumpWidgetWithLocale(
        mockAppBloc: mockAppBloc,
        mockPopularMoviesBloc: mockPopularMoviesBloc,
        mockNowMoviesBloc: mockNowMoviesBloc,
        child: const CinemaMovieHome(),
      );

      expect(find.byType(PopularMoviesPage), findsNothing);
      expect(find.byType(NowPlayingPage), findsOneWidget);
    });

    testWidgets('calls ChangeTabEvent when BottomNavigationBar is tapped',
        (tester) async {
      await tester.pumpWidgetWithLocale(
        mockAppBloc: mockAppBloc,
        mockPopularMoviesBloc: mockPopularMoviesBloc,
        mockNowMoviesBloc: mockNowMoviesBloc,
        child: const CinemaMovieHome(),
      );

      await tester.tap(find.byIcon(Icons.video_chat_sharp));
      await tester.pump();

      verify(() => mockAppBloc.add(const ChangeTabEvent(index: 1))).called(1);
    });

    testWidgets(
        'calls SortPopularMoviesAlphabetically when FAB is pressed on '
        'PopularMoviesPage', (tester) async {
      await tester.pumpWidgetWithLocale(
        mockAppBloc: mockAppBloc,
        mockPopularMoviesBloc: mockPopularMoviesBloc,
        mockNowMoviesBloc: mockNowMoviesBloc,
        child: const CinemaMovieHome(),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      verify(
        () =>
            mockPopularMoviesBloc.add(const SortPopularMoviesAlphabetically()),
      ).called(1);
    });

    testWidgets(
        'calls SortNowMoviesAlphabetically when FAB pressed on NowPlayingPage',
        (tester) async {
      when(() => mockAppBloc.state)
          .thenReturn(const AppState(selectedIndex: 1));

      await tester.pumpWidgetWithLocale(
        mockAppBloc: mockAppBloc,
        mockPopularMoviesBloc: mockPopularMoviesBloc,
        mockNowMoviesBloc: mockNowMoviesBloc,
        child: const CinemaMovieHome(),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      verify(() => mockNowMoviesBloc.add(const SortNowMoviesAlphabetically()))
          .called(1);
    });
  });
}
