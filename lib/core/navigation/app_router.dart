import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/features/auth/login/presentation/login_page.dart';
import 'package:pos/features/auth/select_outlet/presentation/select_outlet_page.dart';
import 'package:pos/features/home/presentation/home_page.dart';

GoRouter createAppRouter(SessionManager sessionManager) {
  return GoRouter(
    initialLocation: AppRoutePaths.login.path,
    redirect: (context, state) async {
      final isLogged = await sessionManager.isLoggedIn;
      final hasOutlet = await sessionManager.hasOutletSelected;
      final location = state.uri.toString();

      final isOnLogin = location.startsWith(AppRoutePaths.login.path);
      final isOnSelectOutlet =
          location.startsWith(AppRoutePaths.selectOutlet.path);

      if (!isLogged && !isOnLogin) {
        return AppRoutePaths.login.path;
      }

      if (isLogged && !hasOutlet && !isOnSelectOutlet && !isOnLogin) {
        return AppRoutePaths.login.path;
      }

      if (isLogged && hasOutlet && isOnLogin) {
        return AppRoutePaths.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutePaths.login.path,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'select-outlet',
            builder: (context, state) => const SelectOutletPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.home.path,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
