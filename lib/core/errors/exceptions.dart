abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => 'AppException: $message (status: $statusCode)';
}

class ServerException extends AppException {
  const ServerException(super.message, [super.statusCode]);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([String? message]) : super(message ?? 'Unauthorized', 401);
}
