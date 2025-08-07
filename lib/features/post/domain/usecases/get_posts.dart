import 'package:starter/features/post/domain/entities/post.dart';
import 'package:starter/features/post/domain/repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts({required this.repository});

  Future<List<Post>> call() {
    return repository.getPosts();
  }
}
