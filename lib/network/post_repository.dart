import 'dart:convert';

import 'package:http/http.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/api_endpoints.dart';

class PostRepository {
  Future<List<Post>> getPosts() async {
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
        return json.map((e) => Post.fromJson(e)).toList();
      } catch (e) {
        throw Exception('Failed to parse todos: $e');
      }
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
