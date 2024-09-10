// ignore_for_file: prefer_const_constructors
import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCinemaApiClient extends Mock implements CinemaApiClient {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  group('MovieResource', () {
    late CinemaApiClient apiClient;
    late MovieResource movieResource;
    late String apiKey;

    setUp(() {
      apiClient = MockCinemaApiClient();
      apiKey = 'api_key';
      movieResource = MovieResource(apiClient: apiClient);
    });
    group('constructor', () {
      test('creates CinemaApiClient without Dio', () {
        expect(
          CinemaApiClient('https://www.baseUrl.com', apiKey: apiKey),
          isNotNull,
        );
      });
    });

    group('fetchPopularMovies', () {
      test('returns CinemaMovieApiResponse on success', () async {
        final mockResponse = MockResponse<Map<String, dynamic>>();
        final responseData = {
          'page': 1,
          'results': <MovieResult>[],
          'total_pages': 1,
          'total_results': 1,
        };

        when(() => mockResponse.data).thenReturn(responseData);
        when(
          () => apiClient.makeRequest<Map<String, dynamic>>(
            url: any(named: 'url'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await movieResource.fetchPopularMovies();

        expect(result.page, 1);
        expect(result.results, isEmpty);
        expect(result.totalPages, 1);
        expect(result.totalResults, 1);
      });

      test('throws CinemaApiError on DioException', () async {
        final dioError = DioException(
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            data: {'error': 'Something went wrong'},
          ),
        );

        when(
          () => apiClient.makeRequest<Map<String, dynamic>>(
            url: any(named: 'url'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(dioError);

        expect(
          () => movieResource.fetchPopularMovies(),
          throwsA(
            isA<CinemaApiError>().having(
              (e) => e.error,
              'error',
              {'error': 'Something went wrong'},
            ),
          ),
        );
      });

      test('throws CinemaApiError on generic error', () async {
        final error = Exception('Generic error');

        when(
          () => apiClient.makeRequest<Map<String, dynamic>>(
            url: any(named: 'url'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(error);

        expect(
          () => movieResource.fetchPopularMovies(),
          throwsA(
            isA<CinemaApiError>().having(
              (e) => e.error,
              'error',
              error,
            ),
          ),
        );
      });
    });

    group('fetchNowPlayingMovies', () {
      test('returns CinemaMovieApiResponse on success', () async {
        final mockResponse = MockResponse<Map<String, dynamic>>();
        final responseData = {
          'page': 1,
          'results': <MovieResult>[],
          'total_pages': 1,
          'total_results': 1,
        };

        when(() => mockResponse.data).thenReturn(responseData);
        when(
          () => apiClient.makeRequest<Map<String, dynamic>>(
            url: any(named: 'url'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await movieResource.fetchNowPlayingMovies(
          today: '2023-09-01',
          weekAgo: '2023-08-25',
        );

        expect(result.page, 1);
        expect(result.results, isEmpty);
        expect(result.totalPages, 1);
        expect(result.totalResults, 1);
      });

      test('throws CinemaApiError on DioException', () async {
        final dioError = DioException(
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            data: {'error': 'Something went wrong'},
          ),
        );

        when(
          () => apiClient.makeRequest<Map<String, dynamic>>(
            url: any(named: 'url'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(dioError);

        expect(
          () => movieResource.fetchNowPlayingMovies(
            today: '2023-09-01',
            weekAgo: '2023-08-25',
          ),
          throwsA(
            isA<CinemaApiError>().having(
              (e) => e.error,
              'error',
              {'error': 'Something went wrong'},
            ),
          ),
        );
      });

      test('throws CinemaApiError on generic error', () async {
        final error = Exception('Generic error');

        when(
          () => apiClient.makeRequest<Map<String, dynamic>>(
            url: any(named: 'url'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(error);

        expect(
          () => movieResource.fetchNowPlayingMovies(
            today: '2023-09-01',
            weekAgo: '2023-08-25',
          ),
          throwsA(
            isA<CinemaApiError>().having(
              (e) => e.error,
              'error',
              error,
            ),
          ),
        );
      });
    });
  });
}
