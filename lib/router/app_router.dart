import 'package:go_router/go_router.dart';
import 'package:starter/screens/detail_screen.dart';
import 'package:starter/screens/list_screen.dart';

class AppRouter {
  static const String list = 'list';
  static const String detail = 'detail';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: list,
        builder: (_, __) => const ListScreen(),
      ),
      GoRoute(
        path: '/detail/:id',
        name: detail,
        builder: (_, state) => DetailScreen(
          id: int.tryParse(state.pathParameters['id'] ?? ''),
        ),
      ),
    ],
  );
}
