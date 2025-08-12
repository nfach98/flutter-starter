import 'package:flutter/material.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/screens/detail_screen.dart';
import 'package:starter/screens/list_screen.dart';
import 'package:starter/screens/login_screen.dart';
import 'package:starter/utils/shared_preferences.dart';

class AppRouter {
  static const String list = '/';
  static const String login = '/login';
  static const String detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case list:
        return MaterialPageRoute(
          builder: (_) => FutureBuilder(
            future: getIt<SharedPreferences>().getString('username'),
            builder: (_, snapshot) {
              final isAuth = snapshot.data?.isNotEmpty ?? false;

              if (isAuth) {
                return const ListScreen();
              } else {
                return const LoginScreen();
              }
            },
          ),
        );
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case detail:
        final args = settings.arguments as int?;
        return MaterialPageRoute(builder: (_) => DetailScreen(id: args));
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
