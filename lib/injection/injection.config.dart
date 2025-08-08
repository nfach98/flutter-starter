// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../bloc/detail/detail_bloc.dart' as _i508;
import '../bloc/list/list_bloc.dart' as _i906;
import '../network/dio_client.dart' as _i667;
import '../network/post_repository.dart' as _i693;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i667.DioClient>(() => _i667.DioClient());
  gh.lazySingleton<_i693.PostRepository>(
      () => _i693.PostRepository(dio: gh<_i667.DioClient>()));
  gh.factory<_i508.DetailBloc>(
      () => _i508.DetailBloc(postRepository: gh<_i693.PostRepository>()));
  gh.factory<_i906.ListBloc>(
      () => _i906.ListBloc(postRepository: gh<_i693.PostRepository>()));
  return getIt;
}
