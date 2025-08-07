import 'package:starter/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> getPostDetail(int id);
}
