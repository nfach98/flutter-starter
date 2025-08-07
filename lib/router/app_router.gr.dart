// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:starter/screens/detail_screen.dart' as _i1;
import 'package:starter/screens/list_screen.dart' as _i2;

/// generated route for
/// [_i1.DetailScreen]
class DetailRoute extends _i3.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    _i4.Key? key,
    int? id,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          DetailRoute.name,
          args: DetailRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<DetailRouteArgs>(orElse: () => const DetailRouteArgs());
      return _i1.DetailScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    this.id,
  });

  final _i4.Key? key;

  final int? id;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, id: $id}';
  }
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
