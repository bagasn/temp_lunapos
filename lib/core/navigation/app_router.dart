import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/features/auth/login/presentation/login_page.dart';
import 'package:pos/features/auth/select_outlet/presentation/select_outlet_page.dart';
import 'package:pos/features/boot/presentation/boot_page.dart';
import 'package:pos/features/home/presentation/home_page.dart';

GoRouter createAppRouter(SessionManager sessionManager) {
  return GoRouter(
    initialLocation: AppRoutePaths.splash.path,
    redirect: (context, state) async {
      final location = state.uri.toString();

      final isBooting = location.startsWith(AppRoutePaths.splash.path);
      if (isBooting) {
        return null;
      }

      final isLogged = await sessionManager.isLoggedIn;
      final hasActiveOutlet = await sessionManager.hasActiveOutlet;

      final isOnLogin = location.startsWith(AppRoutePaths.login.path);
      final isOnSelectOutlet = location.startsWith(
        AppRoutePaths.selectOutlet.path,
      );

      if (!isLogged && !isOnLogin) {
        return AppRoutePaths.login.path;
      }

      if (isLogged && !hasActiveOutlet) {
        if (!isOnSelectOutlet || !isOnLogin) {
          return AppRoutePaths.login.path;
        }
      }

      if (isLogged && hasActiveOutlet && isOnLogin) {
        return AppRoutePaths.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutePaths.splash.navigationPath,
        builder: (context, state) {
          return BootPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.login.navigationPath,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'select-outlet',
            builder: (context, state) => const SelectOutletPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.home.navigationPath,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
