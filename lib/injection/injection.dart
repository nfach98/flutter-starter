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

import 'package:starter/network/post_repository.dart';

class Injection {
  static final postRepository = PostRepository();
}
