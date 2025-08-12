import 'package:auto_route/auto_route.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/router/app_router.gr.dart';
import 'package:starter/utils/shared_preferences.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: ListRoute.page,
          initial: true,
          guards: [AuthGuard()],
        ),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: DetailRoute.page),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final prefs = await getIt<SharedPreferences>().getString('username');
    final isAuthenticated = prefs?.isNotEmpty ?? false;

    if (isAuthenticated) {
      resolver.next();
    } else {
      router.push(const LoginRoute());
    }
  }
}
