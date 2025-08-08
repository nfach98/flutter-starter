import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/instance_manager.dart';
import 'package:starter/app/data/models/post.dart';
import 'package:starter/services/network/api_endpoints.dart';
import 'package:starter/services/network/dio_client.dart';

class PostRepository extends GetxService {
  final DioClient dio;

  PostRepository({required this.dio});

  static PostRepository get to => Get.find();

  Future<List<Post>> getPosts() async {
    final response = await dio.get(ApiEndpoints.posts);

    if (response.statusCode == 200) {
      try {
        final json = response.data as List;
        return json.map((e) => Post.fromJson(e)).toList();
      } catch (e) {
        throw Exception('Failed to parse posts: $e');
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> getPostDetail(int id) async {
    final response = await dio.get('${ApiEndpoints.posts}/$id');

    if (response.statusCode == 200) {
      try {
        return Post.fromJson(response.data);
      } catch (e) {
        throw Exception('Failed to parse post: $e');
      }
    } else {
      throw Exception('Failed to load post');
    }
  }
}
