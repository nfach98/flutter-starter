import 'package:injectable/injectable.dart';
import 'package:starter/models/page_result.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/network/api_endpoints.dart';
import 'package:starter/network/dio_client.dart';

@LazySingleton()
class PostRepository {
  final DioClient dio;

  PostRepository({required this.dio});

  Future<PageResult> getPhotos({
    required int page,
    required int perPage,
  }) async {
    final response = await dio.get(
      ApiEndpoints.curated,
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
      ApiEndpoints.search,
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
      '${ApiEndpoints.photos}/$id',
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
