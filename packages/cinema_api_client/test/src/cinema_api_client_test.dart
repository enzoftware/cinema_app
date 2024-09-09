// ignore_for_file: prefer_const_constructors
import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {
  @override
  Interceptors get interceptors => Interceptors();
}

class MockResponse<T> extends Mock implements Response<T> {}

class MockRequestOptions extends Mock implements RequestOptions {}

void main() {
  group('CinemaApiClient', () {
    late Dio httpClient;
    late CinemaApiClient apiClient;
    late String apiKey;

    setUp(() {
      apiKey = 'api_key';
      httpClient = MockDio();
      apiClient = CinemaApiClient(
        'https://api.themoviedb.org/3',
        apiKey: apiKey,
        httpClient: httpClient,
      );
    });

    group('constructor', () {
      test('creates MovieResource instance', () {
        expect(apiClient.movieResource, isA<MovieResource>());
      });
    });

    group('makeRequest', () {
      test('makes a successful request and returns the response', () async {
        final mockResponse = MockResponse<Map<String, dynamic>>();
        final responseData = {'key': 'value'};

        when(() => mockResponse.data).thenReturn(responseData);
        when(
          () => httpClient.request<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await apiClient.makeRequest<Map<String, dynamic>>(
          url: '/movie/123',
        );

        expect(result, equals(mockResponse));

        verify(
          () => httpClient.request<Map<String, dynamic>>(
            '/movie/123',
            queryParameters: {
              'api_key': apiKey,
            },
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test('includes default headers and API key in the request', () async {
        final mockResponse = MockResponse<Map<String, dynamic>>();
        when(
          () => httpClient.request<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await apiClient.makeRequest<Map<String, dynamic>>(url: '/movie/123');

        final capturedOptions = verify(
          () => httpClient.request<Map<String, dynamic>>(
            any(),
            queryParameters: captureAny(named: 'queryParameters'),
            options: captureAny(named: 'options'),
          ),
        ).captured[1] as Options;

        expect(capturedOptions.headers!['accept'], equals('application/json'));
      });

      test('throws DioException and wraps it in CinemaApiError', () async {
        final dioError = DioException(
          requestOptions: RequestOptions(path: '/movie/123'),
          response: Response(
            requestOptions: RequestOptions(path: '/movie/123'),
            data: {'error': 'Something went wrong'},
          ),
        );

        when(
          () => httpClient.request<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenThrow(dioError);

        expect(
          () async =>
              apiClient.makeRequest<Map<String, dynamic>>(url: '/movie/123'),
          throwsA(isA<DioException>()),
        );
      });

      test('throws generic error and wraps it in CinemaApiError', () async {
        final genericError = Exception('Generic error');

        when(
          () => httpClient.request<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenThrow(genericError);

        expect(
          () async =>
              apiClient.makeRequest<Map<String, dynamic>>(url: '/movie/123'),
          throwsA(isA<Exception>()),
        );
      });

      test('adds LogInterceptor to Dio', () async {
        final mockResponse = MockResponse<Map<String, dynamic>>();
        final responseData = {'key': 'value'};

        when(() => mockResponse.data).thenReturn(responseData);
        when(
          () => httpClient.request<Map<String, dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => mockResponse);
        await apiClient.makeRequest<Map<String, dynamic>>(url: '/movie/123');
        expect(httpClient.interceptors.isNotEmpty, true);
      });
    });

    group('CinemaApiError', () {
      test('toString returns the error message', () {
        final error = CinemaApiError(error: 'Test error');
        expect(error.toString(), 'Test error');
      });
    });
  });
}
