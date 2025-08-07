import 'package:dio/dio.dart';
import 'package:starter/network/api_endpoints.dart';
import 'package:starter/network/api_interceptor.dart';

class DioClient {
  static final _dio = Dio(_getOptions())..interceptors.add(ApiInterceptor());

  static BaseOptions _getOptions() {
    return BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );
  }

  static Future<Response> get(
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

  static Future<Response> put(
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

  static Future<Response> post(
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

  static Future<Response> delete(
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
