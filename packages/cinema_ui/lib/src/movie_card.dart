import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.title,
    required this.releaseDate,
    required this.poster,
    required this.popularity,
    super.key,
  });

  final String title;
  // final List<String> genres;
  final String releaseDate;
  final String poster;
  final double popularity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(releaseDate),
    );
  }
}
