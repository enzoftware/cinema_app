// ignore_for_file: prefer_const_constructors
import 'package:shared_storage/shared_storage.dart';
import 'package:test/test.dart';

void main() {
  group('SharedStorage', () {
    test('can be instantiated', () {
      expect(SharedStorage(), isNotNull);
    });
  });
}
