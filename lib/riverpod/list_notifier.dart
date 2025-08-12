import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/utils/shared_preferences.dart';

part 'list_notifier.g.dart';

@riverpod
class ListNotifier extends _$ListNotifier {
  late PostRepository _postRepository;
  late SharedPreferences _sharedPreferences;

  @override
  Future<List<Post>> build() async {
    state = const AsyncLoading();
    _postRepository = ref.watch(postRepositoryProvider);
    _sharedPreferences = ref.watch(sharedPreferencesProvider);
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

  Future<void> logout() async {
    await _sharedPreferences.remove('username');
  }
}
