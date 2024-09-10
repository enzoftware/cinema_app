import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/l10n/l10n.dart';
import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:cinema_app/popular_movies/popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:shared_storage/shared_storage.dart';

import 'helpers.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpCinemaAppWithLocale({
    required Widget child,
    MovieRepository? mockMovieRepository,
    SharedStorage? mockSharedStorage,
    PopularMoviesBloc? mockPopularMoviesBloc,
    NowMoviesBloc? mockNowMoviesBloc,
    AppBloc? mockAppBloc,
    Locale locale = const Locale('en'),
  }) async {
    await pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: mockMovieRepository ?? MockMovieRepository(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          home: MultiBlocProvider(
            providers: [
              BlocProvider<PopularMoviesBloc>(
                create: (_) => mockPopularMoviesBloc ?? MockPopularMoviesBloc(),
              ),
              BlocProvider<NowMoviesBloc>(
                create: (_) => mockNowMoviesBloc ?? MockNowMoviesBloc(),
              ),
              BlocProvider<AppBloc>(
                create: (_) => mockAppBloc ?? MockAppBloc(),
              ),
            ],
            child: Material(child: child),
          ),
        ),
      ),
    );

    await pump();
  }
}
