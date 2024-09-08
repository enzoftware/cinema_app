import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/l10n/l10n.dart';
import 'package:cinema_app/now_movies/now_movies.dart';
import 'package:cinema_app/popular_movies/popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

class CinemaMovieApp extends StatelessWidget {
  const CinemaMovieApp({required this.movieRepository, super.key});

  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRepository>(
          create: (_) => movieRepository,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const CinemaMovieHome(),
      ),
    );
  }
}

class CinemaMovieHome extends StatelessWidget {
  const CinemaMovieHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final selectedIndex =
              context.select((AppBloc bloc) => bloc.state.selectedIndex);
          return SafeArea(
            child: Scaffold(
              body: [
                const PopularMoviesPage(),
                const NowPlayingPage(),
              ].elementAt(selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.movie_creation_outlined),
                    label: 'Popular Movies',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.video_chat_sharp),
                    label: 'Now Playing Movies',
                  ),
                ],
                currentIndex: selectedIndex,
                onTap: (index) {
                  context.read<AppBloc>().add(ChangeTabEvent(index: index));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
