import 'package:flutter/material.dart';

class CinemaAppBar extends StatelessWidget {
  const CinemaAppBar({required this.title, super.key, this.actions});

  final List<Widget>? actions;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      backgroundColor: Colors.white,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final top = constraints.biggest.height;
          final isCollapsed =
              top <= kToolbarHeight + MediaQuery.of(context).padding.top;

          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              left: isCollapsed ? 0 : 16.0,
              bottom: isCollapsed ? 16.0 : 16.0,
            ),
            centerTitle: isCollapsed, // Center the title when collapsed
            title: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
      actions: actions,
    );
  }
}
