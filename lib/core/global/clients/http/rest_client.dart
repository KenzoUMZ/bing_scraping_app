import 'package:dio/dio.dart';

import 'base_http_client.dart';

/// RestClient with authentication token management and retry logic
class RestClient extends BaseHttp {
  static int _retryCount = 0;
  static const int _maxRetries = 2;

  RestClient({required super.env});

  /// Retrieves the stored authentication token from shared preferences
  Future<String?> getAccessToken() async {
    try {
      // TODO: Replace with actual SharedKeys.authToken when auth is implemented
      // For now, return null as auth system is not yet set up
      return null;
    } catch (error) {
      return null;
    }
  }

  /// Retrieves the stored user ID from shared preferences
  Future<String?> getUserId() async {
    try {
      // TODO: Replace with actual SharedKeys.userId when auth is implemented
      return null;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getAccessToken();
    final userId = await getUserId();

    // Add authorization header if token exists
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Add user ID header if exists
    if (userId != null && userId.isNotEmpty) {
      options.headers['X-User-Id'] = userId;
    }

    // Default headers
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = error.response?.statusCode;

    // Avoid infinite retry loops on refresh endpoint
    if (error.requestOptions.path.contains('auth/refresh')) {
      _retryCount = 0;
      _handleUnauthorized();
      return handler.next(error);
    }

    // Limit retry attempts
    if (_retryCount >= _maxRetries) {
      _retryCount = 0;
      _handleUnauthorized();
      return handler.next(error);
    }

    // Handle 401 Unauthorized - attempt token refresh
    if (statusCode == 401) {
      _retryCount++;

      try {
        // TODO: Implement token refresh logic when auth system is ready
        // For now, just redirect to login
        final refreshed = await _refreshToken();

        if (refreshed != null) {
          return _retryRequest(error, handler, refreshed);
        }

        _handleUnauthorized();
        return handler.next(error);
      } catch (e) {
        _handleUnauthorized();
        return handler.next(error);
      }
    }

    return handler.next(error);
  }

  /// Attempts to refresh the authentication token
  Future<String?> _refreshToken() async {
    try {
      // TODO: Implement actual token refresh call to your backend
      // Example:
      // final response = await dio.post('/auth/refresh');
      // final newToken = response.data['token'];
      // await _saveToken(newToken);
      // return newToken;

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Handles unauthorized access by clearing session and redirecting
  void _handleUnauthorized() {
    // TODO: Implement logout and clear stored tokens
    // Example:
    // await GetIt.instance.get<ISharedPreferences>().remove(SharedKeys.authToken);
    // NavigatorSingleton.I.pushNamedAndRemoveUntil(Routes.login);
  }

  /// Retries a failed request with a new token
  Future<void> _retryRequest(
    DioException error,
    ErrorInterceptorHandler handler,
    String token,
  ) async {
    try {
      // Update the authorization header with new token
      error.requestOptions.headers['Authorization'] = 'Bearer $token';

      final response = await dio.request(
        error.requestOptions.path,
        options: Options(
          method: error.requestOptions.method,
          headers: error.requestOptions.headers,
        ),
        data: error.requestOptions.data,
        queryParameters: error.requestOptions.queryParameters,
      );

      _retryCount = 0;
      return handler.resolve(response);
    } catch (e) {
      return handler.next(e as DioException);
    }
  }
}
