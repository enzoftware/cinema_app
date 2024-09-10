import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:shared_storage/shared_storage.dart';
import 'package:test/test.dart';

class MockCinemaApiClient extends Mock implements CinemaApiClient {}

class MockMovieResource extends Mock implements MovieResource {}

class MockMovieLocalDatabase extends Mock implements MovieLocalDatabase {}

void main() {
  late CinemaApiClient mockApiClient;
  late MovieResource mockMovieResource;
  late MovieRepository movieRepository;
  late MovieLocalDatabase mockMovieLocalDatabase;

  setUp(() {
    mockApiClient = MockCinemaApiClient();
    mockMovieResource = MockMovieResource();
    mockMovieLocalDatabase = MockMovieLocalDatabase();
    movieRepository = MovieRepository(
      apiClient: mockApiClient,
      localDatabase: mockMovieLocalDatabase,
    );

    when(() => mockApiClient.movieResource).thenReturn(mockMovieResource);
  });

  group('MovieRepository', () {
    group('fetchPopularMovies', () {
      test('returns CinemaMovieApiResponse on success', () async {
        const mockResponse = CinemaMovieApiResponse(
          page: 1,
          results: [MovieResult(title: 'Movie 1')],
          totalPages: 1,
          totalResults: 1,
        );

        when(
          () => mockMovieResource.fetchPopularMovies(
            page: any<int>(named: 'page'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await movieRepository.fetchPopularMovies();

        expect(result, equals(mockResponse));
        verify(() => mockMovieResource.fetchPopularMovies()).called(1);
      });

      test('throws FetchPopularMoviesException on error', () async {
        when(
          () => mockMovieResource.fetchPopularMovies(
            page: any<int>(named: 'page'),
          ),
        ).thenThrow(Exception('API error'));

        expect(
          () async => movieRepository.fetchPopularMovies(),
          throwsA(
            isA<FetchPopularMoviesException>()
                .having((e) => e.toString(), 'error', contains('API error')),
          ),
        );

        verify(() => mockMovieResource.fetchPopularMovies()).called(1);
      });
    });

    group('fetchNowPlayingMovies', () {
      test('returns CinemaMovieApiResponse on success', () async {
        const mockResponse = CinemaMovieApiResponse(
          page: 1,
          results: [MovieResult(title: 'Now Playing Movie 1')],
          totalPages: 1,
          totalResults: 1,
        );

        when(
          () => mockMovieResource.fetchNowPlayingMovies(
            today: any<String>(named: 'today'),
            weekAgo: any<String>(named: 'weekAgo'),
            page: any<int>(named: 'page'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await movieRepository.fetchNowPlayingMovies();

        expect(result, equals(mockResponse));
        verify(
          () => mockMovieResource.fetchNowPlayingMovies(
            today: any<String>(named: 'today'),
            weekAgo: any<String>(named: 'weekAgo'),
          ),
        ).called(1);
      });

      test('throws FetchNowPlayingMoviesException on error', () async {
        when(
          () => mockMovieResource.fetchNowPlayingMovies(
            today: any<String>(named: 'today'),
            weekAgo: any<String>(named: 'weekAgo'),
            page: any<int>(named: 'page'),
          ),
        ).thenThrow(Exception('API error'));

        expect(
          () async => movieRepository.fetchNowPlayingMovies(),
          throwsA(
            isA<FetchNowPlayingMoviesException>()
                .having((e) => e.toString(), 'error', contains('API error')),
          ),
        );

        verify(
          () => mockMovieResource.fetchNowPlayingMovies(
            today: any<String>(named: 'today'),
            weekAgo: any<String>(named: 'weekAgo'),
          ),
        ).called(1);
      });
    });
  });
}
