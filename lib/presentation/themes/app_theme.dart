import 'package:flutter/material.dart';
import 'package:starter/presentation/themes/app_color_scheme.dart';
import 'package:starter/presentation/themes/app_text_theme.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: AppColorScheme.light,
      textTheme: AppTextTheme.textTheme,
      fontFamily: AppTextTheme.fontFamily,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: AppColorScheme.dark,
      textTheme: AppTextTheme.textTheme,
      fontFamily: AppTextTheme.fontFamily,
    );
  }
}
