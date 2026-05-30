import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.timeout,
        receiveTimeout: ApiConstants.timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      _authInterceptor(),
      _errorInterceptor(),
    ]);
  }

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // TODO: Attach auth token from secure storage
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) {
        handler.next(error);
      },
    );
  }

  InterceptorsWrapper _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout) {
          throw const NetworkException('Connection timeout');
        }

        if (error.response != null) {
          final statusCode = error.response!.statusCode;
          final message = error.response!.data is Map
              ? (error.response!.data['message'] ?? 'Server error')
              : 'Server error';

          if (statusCode == 401) {
            throw UnauthorizedException(message);
          }

          throw ServerException(message, statusCode);
        }

        handler.next(error);
      },
    );
  }
}
