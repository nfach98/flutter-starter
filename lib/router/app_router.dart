import 'package:go_router/go_router.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/screens/detail_screen.dart';
import 'package:starter/screens/list_screen.dart';
import 'package:starter/screens/login_screen.dart';
import 'package:starter/utils/shared_preferences.dart';

class AppRouter {
  static const String login = 'login';
  static const String list = 'list';
  static const String detail = 'detail';

  static Future<bool> isAuthenticated() async {
    final prefs = await getIt<SharedPreferences>().getString('username');
    return prefs?.isNotEmpty ?? false;
  }

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: list,
        builder: (_, __) => const ListScreen(),
      ),
      GoRoute(
        path: '/login',
        name: login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/detail/:id',
        name: detail,
        builder: (_, state) => DetailScreen(
          id: int.tryParse(state.pathParameters['id'] ?? ''),
        ),
      ),
    ],
    redirect: (_, __) async {
      final isAuth = await isAuthenticated();
      return isAuth ? '/' : '/login';
    },
  );
}
