import 'package:flutter/material.dart';
import 'package:starter/screens/detail_screen.dart';
import 'package:starter/screens/list_screen.dart';

class AppRouter {
  static const String list = '/';
  static const String detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case list:
        return MaterialPageRoute(builder: (_) => const ListScreen());
      case detail:
        final args = settings.arguments as int?;
        return MaterialPageRoute(builder: (_) => DetailScreen(id: args));
      default:
        return MaterialPageRoute(builder: (_) => const ListScreen());
    }
  }
}
