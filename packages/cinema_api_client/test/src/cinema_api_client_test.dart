// ignore_for_file: prefer_const_constructors
import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:test/test.dart';

void main() {
  group('CinemaApiClient', () {
    test('can be instantiated', () {
      expect(CinemaApiClient('baseUrl'), isNotNull);
    });
  });
}
