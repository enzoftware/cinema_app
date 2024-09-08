// ignore_for_file: prefer_const_constructors
import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:test/test.dart';

class _MockCinemaApiClient extends Mock implements CinemaApiClient {}

class _MockMovieResource extends Mock implements MovieResource {}

void main() {
  group('MovieRepository', () {
    late CinemaApiClient apiClient;
    late MovieResource movieResource;

    // Helper method to create a dummy movie response
    CinemaMovieApiResponse newMovieResponse({
      int? page,
      List<MovieResult>? results,
      int? totalPages,
      int? totalResults,
    }) =>
        CinemaMovieApiResponse(
          page: page ?? 1,
          results: results ?? [],
          totalPages: totalPages ?? 1,
          totalResults: totalResults ?? 1,
        );

    // Helper method to create a dummy movie result
    MovieResult newMovie({
      int? id,
      String? title,
    }) =>
        MovieResult(
          id: id ?? 1,
          title: title ?? 'Test Movie',
        );

    setUpAll(() {
      apiClient = _MockCinemaApiClient();
      movieResource = _MockMovieResource();

      when(() => apiClient.movieResource).thenReturn(movieResource);
    });

    test('can be instantiated', () {
      expect(MovieRepository(apiClient: apiClient), isNotNull);
    });

    group('fetchPopularMovies', () {
      test('returns a CinemaMovieApiResponse', () async {
        final movieRepository = MovieRepository(apiClient: apiClient);

        final movieResponse = newMovieResponse(
          results: [newMovie(id: 1, title: 'Movie 1')],
        );

        when(() => movieResource.fetchPopularMovies(page: any(named: 'page')))
            .thenAnswer(
          (_) => Future.value(movieResponse),
        );

        final response = await movieRepository.fetchPopularMovies();

        expect(response, equals(movieResponse));
      });

      test(
          'throws FetchPopularMoviesException if fetching popular movies fails',
          () async {
        final movieRepository = MovieRepository(apiClient: apiClient);

        when(() => movieResource.fetchPopularMovies(page: any(named: 'page')))
            .thenThrow(
          CinemaApiError(error: 'Failed to fetch popular movies'),
        );

        expect(
          () async => movieRepository.fetchPopularMovies(),
          throwsA(
            isA<FetchPopularMoviesException>().having(
              (e) => e.error,
              'error',
              isA<CinemaApiError>(),
            ),
          ),
        );
      });

      test('throws FetchPopularMoviesException with null error', () async {
        final movieRepository = MovieRepository(apiClient: apiClient);

        when(() => movieResource.fetchPopularMovies(page: any(named: 'page')))
            .thenThrow(
          Exception(),
        );

        expect(
          () async => movieRepository.fetchPopularMovies(),
          throwsA(
            isA<FetchPopularMoviesException>().having(
              (e) => e.error,
              'error',
              null,
            ),
          ),
        );
      });
    });

    group('fetchNowPlayingMovies', () {
      test('returns a CinemaMovieApiResponse', () async {
        final movieRepository = MovieRepository(apiClient: apiClient);

        final movieResponse = newMovieResponse(
          results: [newMovie(id: 2, title: 'Now Playing Movie')],
        );

        when(
          () => movieResource.fetchNowPlayingMovies(
            today: any(named: 'today'),
            weekAgo: any(named: 'weekAgo'),
            page: any(named: 'page'),
          ),
        ).thenAnswer(
          (_) => Future.value(movieResponse),
        );

        final response = await movieRepository.fetchNowPlayingMovies();

        expect(response, equals(movieResponse));
      });

      test(
          'throws FetchNowPlayingMoviesException if fetching now playing '
          'movies fails', () async {
        final movieRepository = MovieRepository(apiClient: apiClient);

        when(
          () => movieResource.fetchNowPlayingMovies(
            today: any(named: 'today'),
            weekAgo: any(named: 'weekAgo'),
            page: any(named: 'page'),
          ),
        ).thenThrow(
          CinemaApiError(error: 'Failed to fetch now playing movies'),
        );

        expect(
          () async => movieRepository.fetchNowPlayingMovies(),
          throwsA(
            isA<FetchNowPlayingMoviesException>().having(
              (e) => e.error,
              'error',
              isA<CinemaApiError>(),
            ),
          ),
        );
      });

      test('throws FetchNowPlayingMoviesException with null error', () async {
        final movieRepository = MovieRepository(apiClient: apiClient);

        when(
          () => movieResource.fetchNowPlayingMovies(
            today: any(named: 'today'),
            weekAgo: any(named: 'weekAgo'),
            page: any(named: 'page'),
          ),
        ).thenThrow(
          Exception(),
        );

        expect(
          () async => movieRepository.fetchNowPlayingMovies(),
          throwsA(
            isA<FetchNowPlayingMoviesException>().having(
              (e) => e.error,
              'error',
              null,
            ),
          ),
        );
      });
    });
  });

  group('FetchPopularMoviesException', () {
    test('can be instantiated and has correct toString', () {
      final exception = FetchPopularMoviesException('test error');
      expect(exception.toString(), 'FetchPopularMoviesException: test error');
    });
  });

  group('FetchNowPlayingMoviesException', () {
    test('can be instantiated and has correct toString', () {
      final exception = FetchNowPlayingMoviesException('test error');
      expect(
        exception.toString(),
        'FetchNowPlayingMoviesException: test error',
      );
    });
  });
}
