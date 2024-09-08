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
    this.isLoadingMore = false,
  });

  final List<MovieResult>? movies;
  final bool isLoadingMore;

  // CopyWith method to create a new instance with updated values
  PopularMoviesLoaded copyWith({
    List<MovieResult>? movies,
    bool? isLoadingMore,
  }) {
    return PopularMoviesLoaded(
      movies: movies ?? this.movies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [movies];
}

final class PopularMoviesError extends PopularMoviesState {
  const PopularMoviesError({required this.message});

  final String message;
  @override
  List<Object?> get props => [message];
}
