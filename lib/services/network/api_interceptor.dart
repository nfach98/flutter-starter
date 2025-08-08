import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  static const _encoder = JsonEncoder.withIndent('  ');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => ${options.uri}');
    if (options.headers.entries.isNotEmpty) {
      log('${options.headers.entries}');
    }

    // if (options.data is FormData) {
    //   FormData formData = options.data as FormData;
    //   Map<String, dynamic> multipartFieldsMap = {};

    //   for (var entry in formData.fields) {
    //     final key = entry.key;
    //     final value = entry.value;

    //     if (multipartFieldsMap.containsKey(key)) {
    //       if (multipartFieldsMap[key] is List) {
    //         multipartFieldsMap[key].add(value);
    //       } else {
    //         List<String> values = [multipartFieldsMap[key], value];
    //         multipartFieldsMap[key] = values;
    //       }
    //     } else {
    //       multipartFieldsMap[key] = value;
    //     }
    //   }

    //   log('REQUEST[MULTIPART FIELDS] => ${_encoder.convert(multipartFieldsMap)}');
    // } else {
    //   try {
    //     log(
    //       'REQUEST[PAYLOAD] => payload: ${_encoder.convert(options.data)}',
    //     );
    //   } catch (e) {
    //     log(
    //       'REQUEST[PAYLOAD] => body: object is not JSON but multipart!',
    //     );
    //   }
    // }

    log(' ');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] ${response.requestOptions.path} \n'
        '${_encoder.convert(response.data)}');
    log(' ');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('=========================================');
    log('ERROR[${err.response?.statusCode}] ${err.requestOptions.uri}');
    log('Header: ${err.requestOptions.headers.entries}');
    log('Body: ${err.response}');
    log('=========================================');

    return super.onError(err, handler);
  }
}
