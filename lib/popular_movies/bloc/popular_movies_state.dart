part of 'popular_movies_bloc.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object?> get props => [];
}

final class PopularMoviesInitialLoading extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

final class PopularMoviesLoaded extends PopularMoviesState {
  const PopularMoviesLoaded({
    required this.movies,
    this.favoriteMovies = const [],
    this.isLoadingMore = false,
  });

  final List<MovieResult> movies;
  final List<String> favoriteMovies;
  final bool isLoadingMore;

  // CopyWith method to create a new instance with updated values
  PopularMoviesLoaded copyWith({
    List<MovieResult>? movies,
    List<String>? favoriteMovies,
    bool? isLoadingMore,
  }) {
    return PopularMoviesLoaded(
      movies: movies ?? this.movies,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [movies, favoriteMovies, isLoadingMore];
}

final class PopularMoviesError extends PopularMoviesState {
  const PopularMoviesError({required this.message});

  final String message;
  @override
  List<Object?> get props => [message];
}
