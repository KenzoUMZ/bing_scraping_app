import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core.dart';

abstract class BaseHttp {
  late Dio dio;
  final Env env;

  BaseHttp({required this.env}) {
    dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: {'Content-Type': 'application/json'},
      baseUrl: env.baseUrl,
    );
    if (kDebugMode) {
      dio.interceptors.addAll([
        PrettyDioLogger(responseBody: true, compact: true),
        InterceptorsWrapper(onRequest: onRequest, onError: onError),
      ]);
    } else {
      dio.interceptors.add(
        InterceptorsWrapper(onRequest: onRequest, onError: onError),
      );
    }
  }

  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  );

  Future<void> onError(DioException error, ErrorInterceptorHandler handler);
}
