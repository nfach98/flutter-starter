import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/instance_manager.dart';
import 'package:starter/services/network/api_endpoints.dart';
import 'package:starter/services/network/api_interceptor.dart';

class DioClient extends GetxService {
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

  static DioClient get to => Get.find();

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
