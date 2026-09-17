import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/features/auth/login/presentation/login_page.dart';
import 'package:pos/features/auth/login_pos/presentation/input_pin/login_pos_input_pin.dart';
import 'package:pos/features/auth/login_pos/presentation/select_user/login_pos_user_page.dart';
import 'package:pos/features/auth/select_outlet/presentation/select_outlet_page.dart';
import 'package:pos/features/boot/presentation/boot_page.dart';
import 'package:pos/features/home/presentation/home_page.dart';

GoRouter createAppRouter(SessionManager sessionManager) {
  return GoRouter(
    initialLocation: AppRoutePaths.welcome.path,
    redirect: (context, state) async {
      final location = state.uri.toString();

      final isBooting = location.startsWith(AppRoutePaths.welcome.path);
      if (isBooting) {
        return null;
      }

      final isLogged = await sessionManager.isLoggedIn;
      final hasActiveOutlet = await sessionManager.hasActiveOutlet;
      final hasActiveUser = await sessionManager.hasActiveUser;

      final isOnLogin = location.startsWith(AppRoutePaths.login.path);
      final isOnSelectOutlet = location.startsWith(
        AppRoutePaths.selectOutlet.path,
      );
      final isOnPosLogin = location.startsWith(AppRoutePaths.loginPos.path);

      if (!isOnLogin && !isLogged) {
        return AppRoutePaths.login.path;
      }

      if (isLogged && !hasActiveOutlet) {
        if (!isOnSelectOutlet || !isOnLogin) {
          return AppRoutePaths.login.path;
        }
      }

      if (isLogged && hasActiveOutlet && !hasActiveUser) {
        if (!isOnPosLogin) {
          return AppRoutePaths.loginPos.path;
        }
      }

      if (isLogged && hasActiveOutlet && isOnLogin) {
        return AppRoutePaths.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutePaths.welcome.navigationPath,
        builder: (context, state) {
          return BootPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.login.navigationPath,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: AppRoutePaths.selectOutlet.navigationPath,
            builder: (context, state) => const SelectOutletPage(),
          ),
          GoRoute(
            path: AppRoutePaths.loginPos.navigationPath,
            builder: (context, state) => const LoginPosUserPage(),
            routes: [
              GoRoute(
                path: AppRoutePaths.loginPosInputPin.navigationPath,
                builder: (context, state) {
                  final extra = state.extra as Map<String, String>? ?? {};
                  return LoginPosInputPinPage(
                    userId: extra['userId'] ?? '',
                    fullName: extra['fullName'] ?? '',
                  );
                },
              ),
            ],
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
