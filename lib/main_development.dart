import 'package:cinema_api_client/cinema_api_client.dart';
import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/bootstrap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_storage/shared_storage.dart';

void main() {
  bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();

    const baseUrl = 'https://api.themoviedb.org/3';
    final sharedPreferences = await SharedPreferences.getInstance();
    final httpClient = Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(
        LogInterceptor(requestBody: true),
      );

    final box = await Hive.openBox<List<String>>(
      MovieLocalDatabase.boxName,
    );

    final localDatabase = MovieLocalDatabase(box);

    final apiClient = CinemaApiClient(
      baseUrl,
      apiKey: const String.fromEnvironment('TMDB_API_KEY'),
      httpClient: httpClient,
    );
    final movieRepository = MovieRepository(
      apiClient: apiClient,
      localDatabase: localDatabase,
    );
    return CinemaMovieApp(
      movieRepository: movieRepository,
      sharedStorage: SharedStorage(sharedPreferences),
    );
  });
}
