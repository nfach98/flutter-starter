import 'package:injectable/injectable.dart';
import 'package:starter/models/page_result.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/api_endpoints.dart';
import 'package:starter/network/dio_client.dart';

@LazySingleton()
class PostRepository {
  final DioClient dio;

  PostRepository({required this.dio});

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

  Future<PageResult> getPhotos({
    required int page,
    required int perPage,
  }) async {
    final response = await dio.get(
      'https://api.pexels.com/v1/curated',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );

    if (response.statusCode == 200) {
      try {
        return PageResult.fromJson(response.data);
      } catch (e) {
        throw Exception('Failed to parse photos: $e');
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<PageResult> searchPhotos({
    required String query,
    required int page,
    required int perPage,
  }) async {
    final response = await dio.get(
      'https://api.pexels.com/v1/search',
      queryParameters: {
        'query': query,
        'page': page,
        'per_page': perPage,
      },
    );

    if (response.statusCode == 200) {
      try {
        return PageResult.fromJson(response.data);
      } catch (e) {
        throw Exception('Failed to parse photos: $e');
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<Photo> getPhotoDetail(int id) async {
    final response = await dio.get(
      'https://api.pexels.com/v1/photos//$id',
    );

    if (response.statusCode == 200) {
      try {
        return Photo.fromJson(response.data);
      } catch (e) {
        throw Exception('Failed to parse photo: $e');
      }
    } else {
      throw Exception('Failed to load photo');
    }
  }
}
