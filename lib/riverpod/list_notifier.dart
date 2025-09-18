import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/models/list_state.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/utils/shared_preferences.dart';

part 'list_notifier.g.dart';

@riverpod
class ListNotifier extends _$ListNotifier {
  late PostRepository _postRepository;
  late SharedPreferences _sharedPreferences;

  @override
  Future<ListState?> build() async {
    state = const AsyncLoading();
    _postRepository = ref.watch(postRepositoryProvider);
    _sharedPreferences = ref.watch(sharedPreferencesProvider);
    getPhotos();
    return state.value ?? ListState.initial();
  }

  Future<void> getPhotos() async {
    if (state.value?.page == 1) {
      state = const AsyncLoading();
    }

    final result = await _postRepository.getPhotos(
      page: state.value?.page ?? 1,
      perPage: 12,
    );

    final photos = [...?state.value?.photos, ...?result.photos];
    state = AsyncData(
      state.value?.copyWith(
        photos: photos,
        page: (state.value?.page ?? 1) + 1,
        totalResults: result.totalResults ?? 0,
      ),
    );
  }

  void resetPhotos() {
    state = AsyncData(ListState.initial());
  }

  Future<void> logout() async {
    await _sharedPreferences.remove('username');
  }
}
