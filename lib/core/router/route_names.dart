class RouteNames {
  RouteNames._();

  static const String splash = 'splash';
  static const String login = 'login';
  static const String dashboard = 'dashboard';
  static const String tables = 'tables';
  static const String orders = 'orders';
  static const String kitchen = 'kitchen';
}

class RoutePaths {
  RoutePaths._();

  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String tables = '/tables';
  static const String orders = '/orders/:tableId';
  static const String kitchen = '/kitchen';
}
