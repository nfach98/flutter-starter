import 'package:get/get.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/app/data/models/post.dart';
import 'package:starter/network/post_repository.dart';

class DetailController extends GetxController with StateMixin<Post> {
  final _postRepository = getIt<PostRepository>();
  final id = Get.arguments as int? ?? 0;

  @override
  void onInit() {
    super.onInit();
    fetchPostDetail(id);
  }

  Future<void> fetchPostDetail(int id) async {
    change(null, status: RxStatus.loading());
    try {
      final post = await _postRepository.getPostDetail(id);
      change(post, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
