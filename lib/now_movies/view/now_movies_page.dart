import 'package:cinema_app/app/app.dart';
import 'package:cinema_app/l10n/l10n.dart';
import 'package:cinema_app/now_movies/bloc/now_movies_bloc.dart';
import 'package:cinema_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<NowMoviesBloc>(),
      child: const NowMoviesView(),
    );
  }
}

class NowMoviesView extends StatefulWidget {
  const NowMoviesView({super.key});

  @override
  State<NowMoviesView> createState() => _NowMoviesViewState();
}

class _NowMoviesViewState extends State<NowMoviesView> {
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
    final state = context.read<NowMoviesBloc>().state as NowMoviesDataLoaded;

    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent;

    if (reachedBottom && !state.isLoadingMore) {
      context.read<NowMoviesBloc>().add(const FetchNowPlayingMovies());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((NowMoviesBloc bloc) => bloc.state);
    final displayMode = context.select(
      (AppBloc bloc) => bloc.state.displayMode,
    );
    final l10n = context.l10n;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        CinemaAppBar(
          title: l10n.nowPlayingMoviesTitle,
          actions: [
            const Icon(Icons.favorite),
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
        const NowPlayingMoviesBody(),
        if (state is NowMoviesDataLoaded && state.isLoadingMore)
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

class NowPlayingMoviesBody extends StatelessWidget {
  const NowPlayingMoviesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((NowMoviesBloc bloc) => bloc.state);

    return switch (state) {
      NowMoviesInitialLoading() => const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      NowMoviesDataLoaded() => const NowMoviesData(),
      NowMoviesError() => MovieErrorView(message: state.message),
    };
  }
}

class NowMoviesData extends StatelessWidget {
  const NowMoviesData({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = context.select(
      (NowMoviesBloc bloc) => (bloc.state as NowMoviesDataLoaded).movies,
    );
    final favoriteMovies = context.select(
      (NowMoviesBloc bloc) =>
          (bloc.state as NowMoviesDataLoaded).favoriteMoviesIds,
    );
    final displayMode = context.select(
      (AppBloc bloc) => bloc.state.displayMode,
    );

    return MovieResultListView(
      displayMode: displayMode,
      movies: movies,
      favoriteMovies: favoriteMovies,
      onFavoriteMovieTapped: (index, {isFavorite = false}) {},
    );
  }
}
