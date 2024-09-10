import 'package:bloc_test/bloc_test.dart';
import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:cinema_app/widgets/widgets.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../helpers/helpers.dart';

class MockNowMoviesBloc extends MockBloc<NowMoviesEvent, NowMoviesState>
    implements NowMoviesBloc {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

final movies = [
  {
    'adult': false,
    'backdrop_path': '/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg',
    'genre_ids': [
      16,
      10751,
      35,
      28,
    ],
    'id': 519182,
    'original_language': 'en',
    'original_title': 'Despicable Me 4',
    'overview': 'Gru and Lucy and their girls—Margo, Edith and Agnes—welcome',
    'popularity': 1346.005,
    'poster_path': '/wWba3TaojhK7NdycRhoQpsG0FaH.jpg',
    'release_date': '2024-06-20',
    'title': 'Despicable Me 4',
    'video': false,
    'vote_average': 7.222,
    'vote_count': 1439,
  },
  {
    'adult': false,
    'backdrop_path': '/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg',
    'genre_ids': [
      16,
      10751,
      35,
      28,
    ],
    'id': 5191812,
    'original_language': 'en',
    'original_title': 'Despicable Me 4',
    'overview': 'Gru and Lucy and their girls—Margo, Edith and Agnes—welcome',
    'popularity': 1346.005,
    'poster_path': '/wWba3TaojhK7NdycRhoQpsG0FaH.jpg',
    'release_date': '2024-06-20',
    'title': 'Despicable Me 4',
    'video': false,
    'vote_average': 7.222,
    'vote_count': 1439,
  },
  {
    'adult': false,
    'backdrop_path': '/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg',
    'genre_ids': [
      16,
      10751,
      35,
      28,
    ],
    'id': 5191382,
    'original_language': 'en',
    'original_title': 'Despicable Me 4',
    'overview': 'Gru and Lucy and their girls—Margo, Edith and Agnes—welcome',
    'popularity': 1346.005,
    'poster_path': '/wWba3TaojhK7NdycRhoQpsG0FaH.jpg',
    'release_date': '2024-06-20',
    'title': 'Despicable Me 4',
    'video': false,
    'vote_average': 7.222,
    'vote_count': 1439,
  },
  {
    'adult': false,
    'backdrop_path': '/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg',
    'genre_ids': [
      16,
      10751,
      35,
      28,
    ],
    'id': 51229182,
    'original_language': 'en',
    'original_title': 'Despicable Me 4',
    'overview': 'Gru and Lucy and their girls—Margo, Edith and Agnes—welcome',
    'popularity': 1346.005,
    'poster_path': '/wWba3TaojhK7NdycRhoQpsG0FaH.jpg',
    'release_date': '2024-06-20',
    'title': 'Despicable Me 4',
    'video': false,
    'vote_average': 7.222,
    'vote_count': 1439,
  },
  {
    'adult': false,
    'backdrop_path': '/lgkPzcOSnTvjeMnuFzozRO5HHw1.jpg',
    'genre_ids': [
      16,
      10751,
      35,
      28,
    ],
    'id': 51955182,
    'original_language': 'en',
    'original_title': 'Despicable Me 4',
    'overview': 'Gru and Lucy and their girls—Margo, Edith and Agnes—welcome',
    'popularity': 1346.005,
    'poster_path': '/wWba3TaojhK7NdycRhoQpsG0FaH.jpg',
    'release_date': '2024-06-20',
    'title': 'Despicable Me 4',
    'video': false,
    'vote_average': 7.222,
    'vote_count': 1439,
  },
  {
    'adult': false,
    'backdrop_path': '/9BQqngPfwpeAfK7c2H3cwIFWIVR.jpg',
    'genre_ids': [
      10749,
      18,
    ],
    'id': 1079091,
    'original_language': 'en',
    'original_title': 'It Ends with Us',
    'overview': "When a woman's first love suddenly reenters her life",
    'popularity': 769.307,
    'poster_path': '/4TzwDWpLmb9bWJjlN3iBUdvgarw.jpg',
    'release_date': '2024-08-07',
    'title': 'It Ends with Us',
    'video': false,
    'vote_average': 6.849,
    'vote_count': 249,
  },
  {
    'adult': false,
    'backdrop_path': '/6IrZ3C8qSZ8Tbb32s41ReJOXpI0.jpg',
    'genre_ids': [
      12,
      10751,
      14,
      35,
    ],
    'id': 826510,
    'original_language': 'en',
    'original_title': 'Harold and the Purple Crayon',
    'overview': 'Inside of his book, adventurous Harold can make anything.',
    'popularity': 742.65,
    'poster_path': '/dEsuQOZwdaFAVL26RjgjwGl9j7m.jpg',
    'release_date': '2024-07-31',
    'title': 'Harold and the Purple Crayon',
    'video': false,
    'vote_average': 6.799,
    'vote_count': 92,
  },
];

void main() {
  late MockNowMoviesBloc mockNowMoviesBloc;
  late MockAppBloc mockAppBloc;

  setUp(() {
    mockNowMoviesBloc = MockNowMoviesBloc();
    mockAppBloc = MockAppBloc();
    when(() => mockAppBloc.state).thenReturn(const AppState());
  });

  group('NowPlayingPage', () {
    testWidgets('renders NowMoviesView', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        when(() => mockNowMoviesBloc.state)
            .thenReturn(NowMoviesInitialLoading());

        await tester.pumpCinemaAppWithLocale(
          child: const NowPlayingPage(),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        expect(find.byType(NowMoviesView), findsOneWidget);
      });
    });
  });

  group('NowMoviesView', () {
    testWidgets('renders CustomScrollView with CinemaAppBar and body',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        when(() => mockNowMoviesBloc.state).thenReturn(
          NowMoviesDataLoaded(
            movies: movies.map(MovieResult.fromJson).toList(),
          ),
        );

        await tester.pumpCinemaAppWithLocale(
          child: BlocProvider.value(
            value: mockNowMoviesBloc,
            child: const NowMoviesView(),
          ),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        expect(find.byType(CustomScrollView), findsOneWidget);
        expect(find.byType(CinemaAppBar), findsOneWidget);
      });
    });

    testWidgets('scrolling triggers FetchNowPlayingMovies when reaching bottom',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        when(() => mockNowMoviesBloc.state).thenReturn(
          NowMoviesDataLoaded(
            movies: movies.map(MovieResult.fromJson).toList(),
          ),
        );

        await tester.pumpCinemaAppWithLocale(
          child: const NowMoviesView(),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        // Simulate scrolling to the bottom to trigger fetching more movies
        final scrollableFinder = find.byType(CustomScrollView);
        await tester.drag(scrollableFinder, const Offset(0, -500));
        await tester.pumpAndSettle();

        verify(() => mockNowMoviesBloc.add(const FetchNowPlayingMovies()))
            .called(1);
      });
    });

    testWidgets('renders loading indicator when isLoadingMore is true',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        when(() => mockNowMoviesBloc.state).thenReturn(
          NowMoviesDataLoaded(
            movies: movies.map(MovieResult.fromJson).toList(),
            isLoadingMore: true,
          ),
        );

        await tester.pumpCinemaAppWithLocale(
          child: const NowMoviesView(),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        // Simulate scrolling to the bottom to trigger fetching more movies
        final scrollableFinder = find.byType(CustomScrollView);
        await tester.drag(scrollableFinder, const Offset(0, -500));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsAtLeast(1));
      });
    });
  });

  group('NowPlayingMoviesBody', () {
    testWidgets('renders NowMoviesData when state is NowMoviesDataLoaded',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        when(() => mockNowMoviesBloc.state).thenReturn(
          NowMoviesDataLoaded(
            movies: movies.map(MovieResult.fromJson).toList(),
          ),
        );

        await tester.pumpCinemaAppWithLocale(
          child: const CustomScrollView(
            slivers: [
              NowPlayingMoviesBody(),
            ],
          ),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        expect(find.byType(NowMoviesData), findsOneWidget);
      });
    });

    testWidgets('renders MovieErrorView when state is NowMoviesError',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        when(() => mockNowMoviesBloc.state)
            .thenReturn(const NowMoviesError(message: 'Error loading movies'));

        await tester.pumpCinemaAppWithLocale(
          child: const CustomScrollView(
            slivers: [
              NowPlayingMoviesBody(),
            ],
          ),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        expect(find.byType(MovieErrorView), findsOneWidget);
        expect(find.text('Error loading movies'), findsOneWidget);
      });
    });
  });

  group('NowMoviesData', () {
    testWidgets('renders MovieResultListView with correct data',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        const movieResult = MovieResult(id: 1, title: 'Movie Title');

        when(() => mockNowMoviesBloc.state).thenReturn(
          const NowMoviesDataLoaded(
            movies: [movieResult],
            favoriteMoviesIds: ['1'],
          ),
        );

        await tester.pumpCinemaAppWithLocale(
          child: const CustomScrollView(
            slivers: [
              NowMoviesData(),
            ],
          ),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        expect(find.byType(MovieResultListView), findsOneWidget);
        expect(find.text('Movie Title'), findsOneWidget);
      });
    });

    testWidgets(
        'adds favorite movie when tapping favorite icon and movie is not a '
        'favorite', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        const movieResult = MovieResult(id: 1, title: 'Movie Title');

        when(() => mockNowMoviesBloc.state).thenReturn(
          const NowMoviesDataLoaded(
            movies: [movieResult],
          ),
        );

        await tester.pumpCinemaAppWithLocale(
          child: const CustomScrollView(
            slivers: [
              NowMoviesData(),
            ],
          ),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        await tester.tap(find.byIcon(Icons.favorite_border_outlined));
        await tester.pumpAndSettle();

        verify(
          () => mockNowMoviesBloc.add(
            const AddNowPlayingFavoriteMovie(movieResult),
          ),
        ).called(1);
      });
    });

    testWidgets(
        'removes favorite movie when tapping favorite icon and movie is a '
        'favorite', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        const movieResult = MovieResult(id: 1, title: 'Movie Title');

        when(() => mockNowMoviesBloc.state).thenReturn(
          const NowMoviesDataLoaded(
            movies: [movieResult],
            favoriteMoviesIds: ['1'],
          ),
        );

        await tester.pumpCinemaAppWithLocale(
          child: const CustomScrollView(
            slivers: [
              NowMoviesData(),
            ],
          ),
          mockNowMoviesBloc: mockNowMoviesBloc,
          mockAppBloc: mockAppBloc,
        );

        await tester.tap(find.byIcon(Icons.favorite));
        await tester.pumpAndSettle();

        verify(
          () => mockNowMoviesBloc.add(
            const RemoveNowPlayingFavoriteMovie(movieId: 1),
          ),
        ).called(1);
      });
    });
  });
}
