import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema_models/cinema_models.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(PopularMoviesInitialLoading()) {
    on<FetchPopularMovies>(_onFetchPopularMovies);
    on<SortPopularMoviesAlphabetically>(_onSortMoviesAlphabetically);
  }

  final MovieRepository _movieRepository;

  int _currentPage = 1;

  FutureOr<void> _onFetchPopularMovies(
    FetchPopularMovies event,
    Emitter<PopularMoviesState> emit,
  ) async {
    try {
      List<MovieResult>? previousMovies;
      if (state is PopularMoviesLoaded) {
        previousMovies = (state as PopularMoviesLoaded).movies;
        emit((state as PopularMoviesLoaded).copyWith(isLoadingMore: true));
      }
      final response = await _movieRepository.fetchPopularMovies(
        page: _currentPage,
      );
      _currentPage++;
      emit(
        PopularMoviesLoaded(
          movies: (previousMovies ?? []) + response.results!,
        ),
      );
    } catch (error) {
      emit(PopularMoviesError(message: error.toString()));
      addError(error);
    }
  }

  FutureOr<void> _onSortMoviesAlphabetically(
    SortPopularMoviesAlphabetically event,
    Emitter<PopularMoviesState> emit,
  ) {
    if (state is PopularMoviesLoaded) {
      final sortedMovies =
          List<MovieResult>.from((state as PopularMoviesLoaded).movies)
            ..sort(
              (a, b) => a.title!.compareTo(b.title!),
            );
      emit(PopularMoviesLoaded(movies: sortedMovies));
    }
  }
}
