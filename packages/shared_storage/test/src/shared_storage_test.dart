import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_storage/shared_storage.dart';
import 'package:test/test.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedStorage sharedStorage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sharedStorage = SharedStorage(mockSharedPreferences);
  });

  group('SharedStorage', () {
    test('readString returns the stored value when it exists', () {
      const key = 'testKey';
      const storedValue = 'storedValue';

      when(() => mockSharedPreferences.getString(key)).thenReturn(storedValue);

      final result = sharedStorage.readString(key: key);

      expect(result, equals(storedValue));
      verify(() => mockSharedPreferences.getString(key)).called(1);
    });

    test('readString returns an empty string when no value is found', () {
      const key = 'nonExistingKey';

      when(() => mockSharedPreferences.getString(key)).thenReturn(null);

      final result = sharedStorage.readString(key: key);

      expect(result, equals(''));
      verify(() => mockSharedPreferences.getString(key)).called(1);
    });

    test('writeString saves the value to shared storage', () async {
      const key = 'testKey';
      const value = 'testValue';

      when(() => mockSharedPreferences.setString(key, value))
          .thenAnswer((_) async => true);

      await sharedStorage.writeString(key: key, value: value);

      verify(() => mockSharedPreferences.setString(key, value)).called(1);
    });
  });
}
