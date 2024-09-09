import 'package:flutter/material.dart';

class MovieErrorView extends StatelessWidget {
  const MovieErrorView({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/movie_error.png', height: 300, width: 300),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
