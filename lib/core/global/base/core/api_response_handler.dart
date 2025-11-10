import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core.dart';

class ApiResponseHandler {
  /// Método genérico que trata respostas da API para qualquer tipo [T]
  static Future<DualResponse<Failure, T>> validateResponse<T>(
    Future<Response> Function() request,
    T Function(dynamic data) onSuccess,
  ) async {
    try {
      final response = await request();
      final statusCode = response.statusCode ?? -1;

      if (statusCode >= 200 && statusCode <= 299) {
        if (response.data == null) {
          return ErrorResponse(NullFailure());
        }

        dynamic data = response.data;

        if (data is String) {
          try {
            data = jsonDecode(data);
          } catch (_) {}
        }

        return SuccessReponse(onSuccess(data));
      }

      return ErrorResponse(
        StatusFailure(
          statusCode,
          msg: HttpFailure.fromStatusCode(statusCode).messageToken,
        ),
      );
    } catch (e) {
      return ErrorResponse(
        StatusFailure(-1, msg: HttpFailure.unknown.messageToken),
      );
    }
  }
}

enum HttpFailure {
  unauthorized(401, 'unauthorized'),
  forbidden(403, 'access_denied'),
  notFound(404, 'resource_not_found'),
  serverError(500, 'internal_server_error'),
  connectionTimeout(408, 'connection_timed_out'),
  badResponse(422, 'invalid_response'),
  unknown(-1, 'unknown_error');

  final int statusCode;
  final String messageToken;
  const HttpFailure(this.statusCode, this.messageToken);

  static HttpFailure fromStatusCode(int statusCode) {
    return HttpFailure.values.firstWhere(
      (failure) => failure.statusCode == statusCode,
      orElse: () => HttpFailure.unknown,
    );
  }
}
