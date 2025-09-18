import 'package:flutter/material.dart';

class PhotoPlaceholder extends StatelessWidget {
  const PhotoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.colorScheme.surfaceContainer,
      child: Icon(
        Icons.image,
        size: 48,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
