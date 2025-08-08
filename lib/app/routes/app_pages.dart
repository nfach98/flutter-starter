import 'package:get/get.dart';
import 'package:starter/app/modules/detail/bindings/detail_binding.dart';
import 'package:starter/app/modules/list/bindings/list_binding.dart';
import 'package:starter/app/modules/detail/views/detail_screen.dart';
import 'package:starter/app/modules/list/views/list_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.list;

  static final routes = [
    GetPage(
      name: Routes.list,
      page: () => const ListScreen(),
      binding: ListBinding(),
    ),
    GetPage(
      name: Routes.detail,
      page: () => const DetailScreen(),
      binding: DetailBinding(),
    ),
  ];
}
