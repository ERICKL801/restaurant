import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/tables/presentation/pages/tables_page.dart';
import '../../features/orders/presentation/pages/order_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isChecking = authState.status == AuthStatus.unknown;
      final location = state.matchedLocation;

      if (isChecking) return null;

      if (location == RoutePaths.splash) {
        return isAuthenticated ? RoutePaths.dashboard : RoutePaths.login;
      }

      final isLoginRoute = location == RoutePaths.login;
      final isProtectedRoute = location == RoutePaths.dashboard ||
          location == RoutePaths.tables ||
          location.startsWith('/orders/');

      if (!isAuthenticated && isProtectedRoute) return RoutePaths.login;
      if (isAuthenticated && isLoginRoute) return RoutePaths.dashboard;

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        name: RouteNames.dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: RoutePaths.tables,
        name: RouteNames.tables,
        builder: (context, state) => const TablesPage(),
      ),
      GoRoute(
        path: RoutePaths.orders,
        name: RouteNames.orders,
        builder: (context, state) {
          final tableId = state.pathParameters['tableId']!;
          final extra = state.extra as Map<String, String>?;
          final tableName = extra?['tableName'] ?? 'Mesa';
          return OrderPage(tableId: tableId, tableName: tableName);
        },
      ),
    ],
  );

  ref.listen(authProvider, (_, _) => router.refresh());

  return router;
});
