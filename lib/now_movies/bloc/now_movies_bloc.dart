import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

part 'now_movies_event.dart';
part 'now_movies_state.dart';

class NowMoviesBloc extends Bloc<NowMoviesEvent, NowMoviesState> {
  NowMoviesBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(NowMoviesInitialLoading()) {
    on<FetchNowPlayingMovies>(_onFetchNowPlayingMovies);
    on<SortNowMoviesAlphabetically>(_onSortNowMoviesAlphabetically);
    on<AddNowPlayingFavoriteMovie>(_onAddNowPlayingFavoriteMovie);
    on<RemoveNowPlayingFavoriteMovie>(_onRemoveNowPlayingFavoriteMovie);
  }

  final MovieRepository _movieRepository;

  int _currentPage = 1;

  FutureOr<void> _onFetchNowPlayingMovies(
    NowMoviesEvent event,
    Emitter<NowMoviesState> emit,
  ) async {
    try {
      List<MovieResult>? previousMovies;
      if (state is NowMoviesDataLoaded) {
        previousMovies = (state as NowMoviesDataLoaded).movies;
        emit((state as NowMoviesDataLoaded).copyWith(isLoadingMore: true));
      }
      final response = await _movieRepository.fetchNowPlayingMovies(
        page: _currentPage,
      );
      _currentPage++;
      emit(
        NowMoviesDataLoaded(
          movies: (previousMovies ?? []) + response.results!,
        ),
      );
    } catch (error) {
      emit(NowMoviesError(message: error.toString()));
      addError(error);
    }
  }

  FutureOr<void> _onSortNowMoviesAlphabetically(
    SortNowMoviesAlphabetically event,
    Emitter<NowMoviesState> emit,
  ) {
    if (state is NowMoviesDataLoaded) {
      final sortedMovies =
          List<MovieResult>.from((state as NowMoviesDataLoaded).movies)
            ..sort(
              (a, b) => a.title!.compareTo(b.title!),
            );
      emit((state as NowMoviesDataLoaded).copyWith(movies: sortedMovies));
    }
  }

  FutureOr<void> _onAddNowPlayingFavoriteMovie(
    AddNowPlayingFavoriteMovie event,
    Emitter<NowMoviesState> emit,
  ) {
    _movieRepository.addNewFavoriteMovie(event.movieResult);
    emit(
      NowMoviesDataLoaded(
        movies: (state as NowMoviesDataLoaded).movies,
        favoriteMoviesIds: _movieRepository.getFavoriteMoviesIds(),
      ),
    );
  }

  FutureOr<void> _onRemoveNowPlayingFavoriteMovie(
    RemoveNowPlayingFavoriteMovie event,
    Emitter<NowMoviesState> emit,
  ) {
    _movieRepository.removeFavoriteMovie(id: event.movieId);
    emit(
      NowMoviesDataLoaded(
        movies: (state as NowMoviesDataLoaded).movies,
        favoriteMoviesIds: _movieRepository.getFavoriteMoviesIds(),
      ),
    );
  }
}
