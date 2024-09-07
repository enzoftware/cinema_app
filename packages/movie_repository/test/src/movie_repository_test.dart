// ignore_for_file: prefer_const_constructors
import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:test/test.dart';

void main() {
  group('MovieRepository', () {
    late final CinemaApiClient apiClient;

    setUp(() {
      apiClient = CinemaApiClient('baseUrl');
    });

    test('can be instantiated', () {
      expect(MovieRepository(apiClient: apiClient), isNotNull);
    });
  });
}
