import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter/network/api_endpoints.dart';
import 'package:starter/network/api_interceptor.dart';

part 'dio_client.g.dart';

@LazySingleton()
class DioClient {
  late final Dio _dio;

  DioClient() {
    final options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    _dio = Dio(options);
    _dio.interceptors.add(ApiInterceptor());
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.get(
      url,
      data: body,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.put(
      url,
      data: body,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.get(
      url,
      data: body,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.delete(
      url,
      data: body,
      queryParameters: queryParameters,
    );
    return response;
  }
}

@riverpod
DioClient dioClient(Ref ref) {
  return DioClient();
}
