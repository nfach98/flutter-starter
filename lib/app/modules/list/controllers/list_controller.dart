import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/app/data/models/post.dart';
import 'package:starter/network/post_repository.dart';

class ListController extends GetxController with StateMixin<List<Post>> {
  final _postRepository = getIt<PostRepository>();

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  Future<void> getPosts() async {
    change([], status: RxStatus.loading());
    try {
      final posts = await _postRepository.getPosts();
      change(posts, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error('Failed to load posts'));
    }
  }
}
