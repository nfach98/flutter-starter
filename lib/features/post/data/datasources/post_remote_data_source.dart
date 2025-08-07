import 'dart:convert';

import 'package:http/http.dart';
import 'package:starter/core/network/api_endpoints.dart';
import 'package:starter/features/post/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostDetail(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<PostModel> getPostDetail(int id) async {
    final response = await get(
      Uri.parse('${ApiEndpoints.posts}/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        return PostModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw Exception('Failed to parse post: $e');
      }
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await get(
      Uri.parse(ApiEndpoints.posts),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final json = jsonDecode(response.body) as List;
        return json.map((e) => PostModel.fromJson(e)).toList();
      } catch (e) {
        throw Exception('Failed to parse posts: $e');
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
