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
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PopularMoviesBloc>(
              create: (context) => PopularMoviesBloc(
                movieRepository: context.read<MovieRepository>(),
              )..add(const FetchPopularMovies()),
            ),
            BlocProvider<NowMoviesBloc>(
              create: (context) => NowMoviesBloc(
                movieRepository: context.read<MovieRepository>(),
              )..add(const FetchNowPlayingMovies()),
            ),
          ],
          child: const CinemaMovieHome(),
        ),
      ),
    );
  }
}

class CinemaMovieHome extends StatelessWidget {
  const CinemaMovieHome({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final selectedIndex =
              context.select((AppBloc bloc) => bloc.state.selectedIndex);
          return SafeArea(
            child: Scaffold(
              body: [
                const PopularMoviesPage(),
                const NowPlayingPage(),
              ].elementAt(selectedIndex),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.sort_by_alpha_outlined),
                onPressed: () {
                  final state = context.read<AppBloc>().state;
                  if (state.view() == HomeAppView.popular) {
                    context
                        .read<PopularMoviesBloc>()
                        .add(const SortPopularMoviesAlphabetically());
                  }

                  if (state.view() == HomeAppView.nowPlaying) {
                    context
                        .read<NowMoviesBloc>()
                        .add(const SortNowMoviesAlphabetically());
                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.movie_creation_outlined),
                    label: l10n.popularMoviesTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.video_chat_sharp),
                    label: l10n.nowPlayingMoviesTitle,
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
