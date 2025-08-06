import 'package:flutter/material.dart';

class AppColorScheme {
  static const _seedColor = Colors.deepPurple;

  static ColorScheme get light {
    return ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _seedColor,
    );
  }

  static ColorScheme get dark {
    return ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _seedColor,
    );
  }
}
