import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/l10n/l10n.dart';
import 'package:cinema_app/popular_movies/popular_movies.dart';
import 'package:cinema_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<PopularMoviesBloc>(),
      child: const PopularMoviesView(),
    );
  }
}

class PopularMoviesView extends StatefulWidget {
  const PopularMoviesView({super.key});

  @override
  State<PopularMoviesView> createState() => _PopularMoviesViewState();
}

class _PopularMoviesViewState extends State<PopularMoviesView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() => _onScroll(context));
  }

  /// Check if the user has scrolled to the bottom of the list or grid and then
  /// fetch information again from the next page.
  void _onScroll(BuildContext context) {
    final state =
        context.read<PopularMoviesBloc>().state as PopularMoviesLoaded;

    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent;

    if (reachedBottom && !state.isLoadingMore) {
      context.read<PopularMoviesBloc>().add(const FetchPopularMovies());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((PopularMoviesBloc bloc) => bloc.state);
    final displayMode = context.select(
      (AppBloc bloc) => bloc.state.displayMode,
    );
    final l10n = context.l10n;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        CinemaAppBar(
          title: l10n.popularMoviesTitle,
          actions: [
            DisplayModeAction(
              displayMode: displayMode,
              onTap: () {
                context.read<AppBloc>().add(
                      ChangeDisplayModeEvent(
                        displayMode.toggle(),
                      ),
                    );
              },
            ),
          ],
        ),
        const PopularMovieBody(),
        if (state is PopularMoviesLoaded && state.isLoadingMore)
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
      ],
    );
  }
}

class PopularMovieBody extends StatelessWidget {
  const PopularMovieBody({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((PopularMoviesBloc bloc) => bloc.state);

    return switch (state) {
      PopularMoviesInitialLoading() => const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      PopularMoviesLoaded() => const PopularMoviesData(),
      PopularMoviesError() => MovieErrorView(message: state.message),
    };
  }
}

class PopularMoviesData extends StatelessWidget {
  const PopularMoviesData({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context
        .select((PopularMoviesBloc bloc) => bloc.state as PopularMoviesLoaded);

    final displayMode = context.select(
      (AppBloc bloc) => bloc.state.displayMode,
    );

    return MovieResultListView(
      displayMode: displayMode,
      favoriteMovies: state.favoriteMovies,
      movies: state.movies,
      onFavoriteMovieTapped: (index, {isFavorite = false}) {
        if (isFavorite) {
          context.read<PopularMoviesBloc>().add(
                RemoveFavoritePopularMovie(
                  movieId: state.movies[index].id ?? -1,
                ),
              );
        } else {
          context.read<PopularMoviesBloc>().add(
                AddNewFavoritePopularMovie(movieResult: state.movies[index]),
              );
        }
      },
    );
  }
}
