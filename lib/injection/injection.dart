// import 'package:get_it/get_it.dart';
// import 'package:injectable/injectable.dart';

// import 'injection.config.dart';

// final getIt = GetIt.instance;

// @InjectableInit(
//   initializerName: r'$initGetIt',
//   preferRelativeImports: true,
//   asExtension: false,
// )
// Future<void> configureDependencies() async => $initGetIt(getIt);

import 'package:starter/bloc/detail/detail_bloc.dart';
import 'package:starter/bloc/list/list_bloc.dart';
import 'package:starter/network/post_repository.dart';

class Injection {
  static final _postRepository = PostRepository();
  static final listBloc = ListBloc(
    postRepository: _postRepository,
  );
  static final detailBloc = DetailBloc(
    postRepository: _postRepository,
  );
}
