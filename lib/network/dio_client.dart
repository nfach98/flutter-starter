import 'package:dio/dio.dart';
import 'package:starter/network/api_endpoints.dart';
import 'package:starter/network/api_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    final options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
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
