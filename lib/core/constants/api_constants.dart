class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://localhost:3000/api';
  static const Duration timeout = Duration(seconds: 30);

  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/auth/profile';
}
