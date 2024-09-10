import 'package:shared_preferences/shared_preferences.dart';

/// {@template shared_storage}
/// A class to handle shared storage for cinema-related values.
///
/// This class provides methods to read and write string values
/// to the underlying [SharedPreferences] storage, which is typically used
/// for persisting simple key-value data.
/// {@endtemplate}
class SharedStorage {
  /// {@macro shared_storage}
  ///
  /// Creates an instance of [SharedStorage] with the provided
  /// [SharedPreferences].
  ///
  /// - [sharedPreferences]: An instance of [SharedPreferences] used for data
  /// persistence.
  const SharedStorage(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  /// The [SharedPreferences] instance used to access persistent storage.
  final SharedPreferences _sharedPreferences;

  /// Reads a string value from the shared storage.
  ///
  /// - [key]: The key used to identify the value in the storage.
  ///
  /// Returns the stored string associated with the given [key], or an empty
  /// string if no value is found.
  String readString({required String key}) {
    return _sharedPreferences.getString(key) ?? '';
  }

  /// Writes a string value to the shared storage.
  ///
  /// - [key]: The key used to identify the value in the storage.
  /// - [value]: The string value to store.
  ///
  /// Saves the [value] under the given [key] asynchronously.
  Future<void> writeString({
    required String key,
    required String value,
  }) async {
    await _sharedPreferences.setString(key, value);
  }
}
