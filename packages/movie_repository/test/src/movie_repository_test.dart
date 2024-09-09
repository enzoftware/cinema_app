import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:test/test.dart';

// Mocks for API client and resources
class MockCinemaApiClient extends Mock implements CinemaApiClient {}

class MockMovieResource extends Mock implements MovieResource {}

void main() {
  late CinemaApiClient mockApiClient;
  late MovieResource mockMovieResource;
  late MovieRepository movieRepository;

  setUp(() {
    // Initialize mocks and repository
    mockApiClient = MockCinemaApiClient();
    mockMovieResource = MockMovieResource();
    movieRepository = MovieRepository(apiClient: mockApiClient);

    // Link movieResource to the mockApiClient
    when(() => mockApiClient.movieResource).thenReturn(mockMovieResource);
  });

  group('MovieRepository', () {
    group('fetchPopularMovies', () {
      test('returns CinemaMovieApiResponse on success', () async {
        // Mock successful API response
        const mockResponse = CinemaMovieApiResponse(
          page: 1,
          results: [MovieResult(title: 'Movie 1')],
          totalPages: 1,
          totalResults: 1,
        );

        // When the movieResource's fetchPopularMovies is called,
        // return the mock response
        when(
          () => mockMovieResource.fetchPopularMovies(
            page: any<int>(named: 'page'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Call the fetchPopularMovies method
        final result = await movieRepository.fetchPopularMovies();

        // Verify the result is as expected
        expect(result, equals(mockResponse));
        verify(() => mockMovieResource.fetchPopularMovies()).called(1);
      });

      test('throws FetchPopularMoviesException on error', () async {
        // Simulate an exception from the API call
        when(
          () => mockMovieResource.fetchPopularMovies(
            page: any<int>(named: 'page'),
          ),
        ).thenThrow(Exception('API error'));

        // Verify that FetchPopularMoviesException is thrown
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
        // Mock successful API response
        const mockResponse = CinemaMovieApiResponse(
          page: 1,
          results: [MovieResult(title: 'Now Playing Movie 1')],
          totalPages: 1,
          totalResults: 1,
        );

        // When the movieResource's fetchNowPlayingMovies is called, return
        // the mock response
        when(
          () => mockMovieResource.fetchNowPlayingMovies(
            today: any<String>(named: 'today'),
            weekAgo: any<String>(named: 'weekAgo'),
            page: any<int>(named: 'page'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Call the fetchNowPlayingMovies method
        final result = await movieRepository.fetchNowPlayingMovies();

        // Verify the result is as expected
        expect(result, equals(mockResponse));
        verify(
          () => mockMovieResource.fetchNowPlayingMovies(
            today: any<String>(named: 'today'),
            weekAgo: any<String>(named: 'weekAgo'),
          ),
        ).called(1);
      });

      test('throws FetchNowPlayingMoviesException on error', () async {
        // Simulate an exception from the API call
        when(
          () => mockMovieResource.fetchNowPlayingMovies(
            today: any<String>(named: 'today'),
            weekAgo: any<String>(named: 'weekAgo'),
            page: any<int>(named: 'page'),
          ),
        ).thenThrow(Exception('API error'));

        // Verify that FetchNowPlayingMoviesException is thrown
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
