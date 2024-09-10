import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cinema_movie_api_response.g.dart';

/// {@template cinema_movie_api_response}
/// A class representing the response from a cinema movie API.
///
/// This class contains metadata about the paginated results from the API,
/// including the current page, the list of results, and the total number
/// of pages and results.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class CinemaMovieApiResponse extends Equatable {
  /// {@macro cinema_movie_api_response}
  const CinemaMovieApiResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  /// Converts a JSON map into an instance of [CinemaMovieApiResponse].
  factory CinemaMovieApiResponse.fromJson(Map<String, dynamic> json) =>
      _$CinemaMovieApiResponseFromJson(json);

  /// The current page of the API response.
  final int? page;

  /// A list of movie results returned from the API.
  final List<MovieResult>? results;

  /// The total number of pages available in the API response.
  @JsonKey(name: 'total_pages')
  final int? totalPages;

  /// The total number of results available in the API response.
  @JsonKey(name: 'total_results')
  final int? totalResults;

  /// Converts this [CinemaMovieApiResponse] instance into a JSON map.
  Map<String, dynamic> toJson() => _$CinemaMovieApiResponseToJson(this);

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}

/// {@template result}
/// A class representing a single movie result in the API response.
///
/// This class contains details about a specific movie, such as the title,
/// release date, vote count, and more.
/// {@endtemplate}
@JsonSerializable()
class MovieResult extends Equatable {
  /// {@macro result}
  const MovieResult({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  /// Converts a JSON map into an instance of [MovieResult].
  factory MovieResult.fromJson(Map<String, dynamic> json) =>
      _$MovieResultFromJson(json);

  /// Whether the movie is intended for adult audiences.
  final bool? adult;

  /// The path to the movie's backdrop image.
  ///
  /// This is typically a URL path.
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  /// The list of genre IDs associated with the movie.
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  /// The unique identifier for the movie.
  final int? id;

  /// The original language of the movie, represented by a language code.
  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  /// The original title of the movie.
  @JsonKey(name: 'original_title')
  final String? originalTitle;

  /// A brief overview or synopsis of the movie.
  final String? overview;

  /// The movie's popularity score.
  ///
  /// This value is typically provided by the API based on user interactions or
  /// ratings.
  final double? popularity;

  /// The path to the movie's poster image.
  ///
  /// This is typically a URL path.
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  /// The release date of the movie.
  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;

  /// A formatted version of the movie's release date.
  ///
  /// Uses the `yyyy-MM-dd` format.
  String get formattedReleaseDate => releaseDate?.toFormattedDate() ?? '';

  /// The title of the movie.
  final String? title;

  /// Whether the movie has an associated video (e.g., a trailer).
  final bool? video;

  /// The average vote score for the movie.
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  /// The total number of votes the movie has received.
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  /// Converts this [MovieResult] instance into a JSON map.
  Map<String, dynamic> toJson() => _$MovieResultToJson(this);

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}

/// An extension on [DateTime] to provide a method for formatting dates.
extension XDateTime on DateTime {
  /// Formats the [DateTime] into a `yyyy-MM-dd` string.
  String toFormattedDate() {
    const datePattern = 'yyyy-MM-dd';
    return DateFormat(datePattern).format(this);
  }
}
