// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:starter/app/modules/detail/bindings/detail_binding.dart';
import 'package:starter/app/modules/list/bindings/list_binding.dart';
import 'package:starter/app/modules/detail/views/detail_screen.dart';
import 'package:starter/app/modules/list/views/list_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LIST;

  static final routes = [
    GetPage(
      name: Routes.LIST,
      page: () => const ListScreen(),
      binding: ListBinding(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => const DetailScreen(),
      binding: DetailBinding(),
    ),
  ];
}
