part of 'popular_movies_bloc.dart';

sealed class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularMovies extends PopularMoviesEvent {
  const FetchPopularMovies();
}

class AddNewFavoritePopularMovie extends PopularMoviesEvent {
  const AddNewFavoritePopularMovie({required this.movieResult});

  final MovieResult movieResult;

  @override
  List<Object?> get props => [movieResult];
}

class RemoveFavoritePopularMovie extends PopularMoviesEvent {
  const RemoveFavoritePopularMovie({required this.movieId});

  final int movieId;

  @override
  List<Object?> get props => [movieId];
}

class SortPopularMoviesAlphabetically extends PopularMoviesEvent {
  const SortPopularMoviesAlphabetically();
}
