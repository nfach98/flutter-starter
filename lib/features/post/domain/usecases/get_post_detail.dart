import 'package:starter/features/post/domain/entities/post.dart';
import 'package:starter/features/post/domain/repositories/post_repository.dart';

class GetPostDetail {
  final PostRepository repository;

  GetPostDetail({required this.repository});

  Future<Post> call(int id) {
    return repository.getPostDetail(id);
  }
}
