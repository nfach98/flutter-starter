import 'package:auto_route/auto_route.dart';
import 'package:starter/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ListRoute.page, initial: true),
        AutoRoute(page: DetailRoute.page),
      ];
}
