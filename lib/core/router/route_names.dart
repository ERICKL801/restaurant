class RouteNames {
  RouteNames._();

  static const String splash = 'splash';
  static const String login = 'login';
  static const String dashboard = 'dashboard';
  static const String tables = 'tables';
  static const String orders = 'orders';
}

class RoutePaths {
  RoutePaths._();

  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String tables = '/tables';
  static const String orders = '/orders/:tableId';
}
