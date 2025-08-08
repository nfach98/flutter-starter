import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/post_repository.dart';

part 'list_notifier.g.dart';

@riverpod
class ListNotifier extends _$ListNotifier {
  late PostRepository _postRepository;

  @override
  Future<List<Post>> build() async {
    _postRepository = ref.watch(postRepositoryProvider);
    fetchPosts();
    return state.value ?? [];
  }

  Future<void> fetchPosts() async {
    state = const AsyncLoading();

    try {
      final posts = await _postRepository.getPosts();
      state = AsyncData(posts);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
