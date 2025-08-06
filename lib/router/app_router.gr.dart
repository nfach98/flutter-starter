// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:starter/screens/detail_screen.dart' as _i1;
import 'package:starter/screens/list_screen.dart' as _i2;

/// generated route for
/// [_i1.DetailScreen]
class DetailRoute extends _i3.PageRouteInfo<void> {
  const DetailRoute({List<_i3.PageRouteInfo>? children})
      : super(
          DetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.DetailScreen();
    },
  );
}

/// generated route for
/// [_i2.ListScreen]
class ListRoute extends _i3.PageRouteInfo<void> {
  const ListRoute({List<_i3.PageRouteInfo>? children})
      : super(
          ListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.ListScreen();
    },
  );
}
