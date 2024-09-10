part of 'now_movies_bloc.dart';

sealed class NowMoviesEvent extends Equatable {
  const NowMoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMovies extends NowMoviesEvent {
  const FetchNowPlayingMovies();
}

class AddNowPlayingFavoriteMovie extends NowMoviesEvent {
  const AddNowPlayingFavoriteMovie(this.movieResult);

  final MovieResult movieResult;

  @override
  List<Object?> get props => [movieResult];
}

class RemoveNowPlayingFavoriteMovie extends NowMoviesEvent {
  const RemoveNowPlayingFavoriteMovie({required this.movieId});

  final int movieId;

  @override
  List<Object?> get props => [movieId];
}

class SortNowMoviesAlphabetically extends NowMoviesEvent {
  const SortNowMoviesAlphabetically();
}
