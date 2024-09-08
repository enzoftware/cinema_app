import 'package:flutter/material.dart';

/// {@template tmdb_image}
/// A widget that displays an image from The Movie Database (TMDB) API.
///
/// The image is loaded from the TMDB server using the provided [path] and
/// rendered with the specified [width] and [height]. While the image is
/// loading, a loading indicator is displayed. If the image fails to load,
/// an error message is shown.
/// {@endtemplate}
class TMDBImage extends StatelessWidget {
  /// {@macro tmdb_image}
  ///
  /// Constructs a [TMDBImage] widget that displays an image from TMDB.
  ///
  /// - [path] is the relative URL path to the movie poster or image.
  /// - [width] is the width of the image.
  /// - [height] is the height of the image.
  const TMDBImage({
    required this.path,
    required this.width,
    required this.height,
    super.key,
  });

  /// The relative path to the TMDB image.
  ///
  /// This path is appended to the base TMDB URL to form the full image URL.
  final String path;

  /// The width of the image.
  final double width;

  /// The height of the image.
  final double height;

  @override
  Widget build(BuildContext context) {
    const baseUrl = 'https://image.tmdb.org/t/p/w500';

    return Image.network(
      '$baseUrl$path',
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator.adaptive(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline),
            Text('Error'),
          ],
        );
      },
    );
  }
}
