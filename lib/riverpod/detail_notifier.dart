import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/post_repository.dart';

part 'detail_notifier.g.dart';

@riverpod
class DetailNotifier extends _$DetailNotifier {
  late PostRepository _postRepository;

  @override
  Future<Post?> build() async {
    _postRepository = ref.watch(postRepositoryProvider);
    state = const AsyncLoading();
    return state.value;
  }

  Future<void> fetchPostDetail(int id) async {
    state = const AsyncLoading();

    try {
      final post = await _postRepository.getPostDetail(id);
      state = AsyncData(post);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
