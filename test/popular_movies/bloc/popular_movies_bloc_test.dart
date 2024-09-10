import 'package:bloc_test/bloc_test.dart';
import 'package:cinema_app/popular_movies/popular_movies.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    popularMoviesBloc = PopularMoviesBloc(movieRepository: mockMovieRepository);
  });

  group('PopularMoviesBloc', () {
    const movie1 = MovieResult(id: 1, title: 'Movie 1');
    const movie2 = MovieResult(id: 2, title: 'Movie 2');
    const movieList = [movie1, movie2];
    const favoriteMoviesIds = ['1', '2'];

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoaded] when FetchPopularMovies is added',
      setUp: () {
        when(() => mockMovieRepository.getFavoriteMoviesIds())
            .thenReturn(favoriteMoviesIds);
        when(
          () => mockMovieRepository.fetchPopularMovies(
            page: any(named: 'page'),
          ),
        ).thenAnswer(
          (_) async => const CinemaMovieApiResponse(results: movieList),
        );
      },
      build: () => popularMoviesBloc,
      act: (bloc) => bloc.add(const FetchPopularMovies()),
      expect: () => [
        const PopularMoviesLoaded(
          movies: movieList,
          favoriteMovies: favoriteMoviesIds,
        ),
      ],
      verify: (_) {
        verify(
          () => mockMovieRepository.fetchPopularMovies(
            page: any(named: 'page'),
          ),
        ).called(1);
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesError] when FetchPopularMovies throws an error',
      setUp: () {
        when(
          () => mockMovieRepository.fetchPopularMovies(
            page: any(named: 'page'),
          ),
        ).thenThrow(FetchPopularMoviesException('Error fetching movies'));
      },
      build: () => popularMoviesBloc,
      act: (bloc) => bloc.add(const FetchPopularMovies()),
      expect: () => [
        const PopularMoviesError(message: 'Error fetching movies'),
      ],
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoaded] with sorted movies when '
      'SortPopularMoviesAlphabetically is added',
      build: () => popularMoviesBloc,
      seed: () => const PopularMoviesLoaded(movies: [movie2, movie1]),
      act: (bloc) => bloc.add(const SortPopularMoviesAlphabetically()),
      expect: () => [
        const PopularMoviesLoaded(movies: [movie1, movie2]),
      ],
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoaded] with updated favorite movies when '
      'AddNewFavoritePopularMovie is added',
      setUp: () {
        when(() => mockMovieRepository.addNewFavoriteMovie(movie1))
            .thenReturn(null);
        when(() => mockMovieRepository.getFavoriteMoviesIds())
            .thenReturn(['1']);
      },
      build: () => popularMoviesBloc,
      seed: () => const PopularMoviesLoaded(movies: [movie1]),
      act: (bloc) =>
          bloc.add(const AddNewFavoritePopularMovie(movieResult: movie1)),
      expect: () => [
        const PopularMoviesLoaded(movies: [movie1], favoriteMovies: ['1']),
      ],
      verify: (_) {
        verify(() => mockMovieRepository.addNewFavoriteMovie(movie1)).called(1);
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoaded] with updated favorite movies when '
      'RemoveFavoritePopularMovie is added',
      setUp: () {
        when(() => mockMovieRepository.removeFavoriteMovie(id: 1))
            .thenReturn(null);
        when(() => mockMovieRepository.getFavoriteMoviesIds()).thenReturn([]);
      },
      build: () => popularMoviesBloc,
      seed: () =>
          const PopularMoviesLoaded(movies: [movie1], favoriteMovies: ['1']),
      act: (bloc) => bloc.add(const RemoveFavoritePopularMovie(movieId: 1)),
      expect: () => [
        const PopularMoviesLoaded(movies: [movie1]),
      ],
      verify: (_) {
        verify(() => mockMovieRepository.removeFavoriteMovie(id: 1)).called(1);
      },
    );
  });
}
