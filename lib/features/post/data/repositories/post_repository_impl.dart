import 'package:starter/features/post/data/datasources/post_remote_data_source.dart';
import 'package:starter/features/post/domain/entities/post.dart';
import 'package:starter/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Post> getPostDetail(int id) async {
    final post = await remoteDataSource.getPostDetail(id);
    return Post(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
    );
  }

  @override
  Future<List<Post>> getPosts() async {
    final posts = await remoteDataSource.getPosts();
    return posts
        .map((e) => Post(
              userId: e.userId,
              id: e.id,
              title: e.title,
              body: e.body,
            ))
        .toList();
  }
}
