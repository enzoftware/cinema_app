import 'package:bloc_test/bloc_test.dart';
import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

class MockMovieResult extends Mock implements MovieResult {}

void main() {
  late NowMoviesBloc nowMoviesBloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    nowMoviesBloc = NowMoviesBloc(movieRepository: mockMovieRepository);
  });

  tearDown(() {
    nowMoviesBloc.close();
  });

  group('NowMoviesBloc', () {
    test('initial state is NowMoviesInitialLoading', () {
      expect(nowMoviesBloc.state, equals(NowMoviesInitialLoading()));
    });

    blocTest<NowMoviesBloc, NowMoviesState>(
      'emits NowMoviesDataLoaded when FetchNowPlayingMovies is successful',
      build: () {
        const movieResult1 = MovieResult(id: 1, title: 'Movie 1');
        const movieResult2 = MovieResult(id: 2, title: 'Movie 2');
        const response =
            CinemaMovieApiResponse(results: [movieResult1, movieResult2]);

        when(
          () => mockMovieRepository.fetchNowPlayingMovies(
            page: any(named: 'page'),
          ),
        ).thenAnswer((_) async => response);

        return nowMoviesBloc;
      },
      act: (bloc) {
        bloc.add(const FetchNowPlayingMovies());
      },
      expect: () => [
        const NowMoviesDataLoaded(
          movies: [
            MovieResult(id: 1, title: 'Movie 1'),
            MovieResult(id: 2, title: 'Movie 2'),
          ],
        ),
      ],
      verify: (_) {
        verify(
          () => mockMovieRepository.fetchNowPlayingMovies(
            page: any(named: 'page'),
          ),
        ).called(1);
      },
    );

    blocTest<NowMoviesBloc, NowMoviesState>(
      'emits NowMoviesError when FetchNowPlayingMovies fails',
      build: () {
        when(
          () => mockMovieRepository.fetchNowPlayingMovies(
            page: any(named: 'page'),
          ),
        ).thenThrow(Exception('Failed to fetch now playing movies'));

        return nowMoviesBloc;
      },
      act: (bloc) {
        bloc.add(const FetchNowPlayingMovies());
      },
      expect: () => [
        const NowMoviesError(
          message: 'Exception: Failed to fetch now playing movies',
        ),
      ],
    );

    blocTest<NowMoviesBloc, NowMoviesState>(
      'loads more movies and sets isLoadingMore to true when '
      'FetchNowPlayingMovies is called with previous movies',
      build: () {
        const movieResult = MovieResult(id: 3, title: 'Movie 3');
        const response = CinemaMovieApiResponse(results: [movieResult]);

        when(
          () => mockMovieRepository.fetchNowPlayingMovies(
            page: any(named: 'page'),
          ),
        ).thenAnswer((_) async => response);

        return nowMoviesBloc;
      },
      seed: () => const NowMoviesDataLoaded(
        movies: [
          MovieResult(id: 1, title: 'Movie 1'),
          MovieResult(id: 2, title: 'Movie 2'),
        ],
      ),
      act: (bloc) {
        bloc.add(const FetchNowPlayingMovies());
      },
      expect: () => [
        const NowMoviesDataLoaded(
          movies: [
            MovieResult(id: 1, title: 'Movie 1'),
            MovieResult(id: 2, title: 'Movie 2'),
          ],
          isLoadingMore: true,
        ),
        const NowMoviesDataLoaded(
          movies: [
            MovieResult(id: 1, title: 'Movie 1'),
            MovieResult(id: 2, title: 'Movie 2'),
            MovieResult(id: 3, title: 'Movie 3'),
          ],
        ),
      ],
    );

    blocTest<NowMoviesBloc, NowMoviesState>(
      'emits sorted movies when SortNowMoviesAlphabetically is called',
      build: () {
        return nowMoviesBloc;
      },
      seed: () => const NowMoviesDataLoaded(
        movies: [
          MovieResult(id: 2, title: 'B Movie'),
          MovieResult(id: 1, title: 'A Movie'),
        ],
      ),
      act: (bloc) {
        bloc.add(const SortNowMoviesAlphabetically());
      },
      expect: () => [
        const NowMoviesDataLoaded(
          movies: [
            MovieResult(id: 1, title: 'A Movie'),
            MovieResult(id: 2, title: 'B Movie'),
          ],
        ),
      ],
    );
  });
}
