import 'package:cinema_app/app/app.dart';
import 'package:flutter/material.dart';

class DisplayModeAction extends StatelessWidget {
  const DisplayModeAction({required this.displayMode, super.key, this.onTap});
  final DisplayMode displayMode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: displayMode == DisplayMode.list
          ? const Icon(Icons.grid_on)
          : const Icon(Icons.list),
    );
  }
}
