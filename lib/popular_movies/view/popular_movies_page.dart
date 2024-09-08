import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/popular_movies/popular_movies.dart';
import 'package:cinema_ui/cinema_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PopularMoviesBloc(
        movieRepository: context.read<MovieRepository>(),
      )..add(const FetchPopularMovies()),
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() => _onScroll(context));
  }

  /// Check if the user has scrolled to the bottom of the list or grid and then
  /// fetch information again from the next page.
  void _onScroll(BuildContext context) {
    final state =
        context.read<PopularMoviesBloc>().state as PopularMoviesLoaded;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !state.isLoadingMore) {
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

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const SliverAppBar(
          centerTitle: true,
          pinned: true,
          title: Text(
            'Popular Movies',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            Icon(Icons.favorite),
            DisplayModeAction(),
          ],
        ),
        const PopularMovieBody(),
        if (state is PopularMoviesLoaded && !state.isLoadingMore)
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
      PopularMoviesError() =>
        const SliverFillRemaining(child: Center(child: Text('error'))),
    };
  }
}

class DisplayModeAction extends StatelessWidget {
  const DisplayModeAction({super.key});

  @override
  Widget build(BuildContext context) {
    final displayMode =
        context.select((AppBloc bloc) => bloc.state.displayMode);
    return InkWell(
      onTap: () {
        final newDisplayMode = displayMode == DisplayMode.list
            ? DisplayMode.grid
            : DisplayMode.list;
        context.read<AppBloc>().add(ChangeDisplayModeEvent(newDisplayMode));
      },
      child: displayMode == DisplayMode.list
          ? const Icon(Icons.grid_on)
          : const Icon(Icons.list),
    );
  }
}

class PopularMoviesData extends StatelessWidget {
  const PopularMoviesData({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = context.select(
      (PopularMoviesBloc bloc) => (bloc.state as PopularMoviesLoaded).movies!,
    );
    final displayMode =
        context.select((AppBloc bloc) => bloc.state.displayMode);

    return displayMode == DisplayMode.list
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final movie = movies[index];
                return MovieCard.list(
                  title: movie.title ?? '',
                  releaseDate: movie.formattedReleaseDate,
                  poster: movie.posterPath ?? '',
                  popularity: movie.popularity ?? 0.0,
                );
              },
              childCount: movies.length,
            ),
          )
        : SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final movie = movies[index];
                return MovieCard.grid(
                  title: movie.title ?? '',
                  releaseDate: movie.formattedReleaseDate,
                  poster: movie.posterPath ?? '',
                  popularity: movie.popularity ?? 0.0,
                );
              },
              childCount: movies.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
          );
  }
}
