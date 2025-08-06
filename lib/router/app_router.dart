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
        return MaterialPageRoute(builder: (_) => const DetailScreen());
      default:
        return MaterialPageRoute(builder: (_) => const ListScreen());
    }
  }
}
