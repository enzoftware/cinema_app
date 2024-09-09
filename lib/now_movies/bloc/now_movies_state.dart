part of 'now_movies_bloc.dart';

sealed class NowMoviesState extends Equatable {
  const NowMoviesState();

  @override
  List<Object?> get props => [];
}

final class NowMoviesInitialLoading extends NowMoviesState {}

final class NowMoviesDataLoaded extends NowMoviesState {
  const NowMoviesDataLoaded({
    required this.movies,
    this.isLoadingMore = false,
  });

  final List<MovieResult> movies;
  final bool isLoadingMore;

  @override
  List<Object?> get props => [movies, isLoadingMore];

  /// Creates a copy of the current instance with the ability to override
  /// certain fields such as [movies] or [isLoadingMore].
  NowMoviesDataLoaded copyWith({
    List<MovieResult>? movies,
    bool? isLoadingMore,
  }) {
    return NowMoviesDataLoaded(
      movies: movies ?? this.movies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class NowMoviesError extends NowMoviesState {
  const NowMoviesError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
