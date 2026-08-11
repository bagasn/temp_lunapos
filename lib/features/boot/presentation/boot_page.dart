import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/generated/assets.gen.dart';
import 'package:pos/generated/colors.gen.dart';

class BootPage extends StatelessWidget {
  const BootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _BootContent();
  }
}

class _BootContent extends StatefulWidget {
  const _BootContent();

  @override
  State<_BootContent> createState() => __BootContentState();
}

class __BootContentState extends State<_BootContent> {
  @override
  void initState() {
    super.initState();
    _checkUserAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.imgLunaposBrandWhite.svg(width: 350),
            SizedBox(height: 42),

            Text(
              'Preparing the aplication, please wait...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _checkUserAuth() async {
    final session = locator<SessionManager>();
    final isLoggedIn = await session.isLoggedIn;
    final hasActiveOutlet = await session.hasActiveOutlet;

    String redirectPath;
    if (isLoggedIn && hasActiveOutlet) {
      redirectPath = AppRoutePaths.home.path;
    } else {
      redirectPath = AppRoutePaths.login.path;
    }

    await Future.delayed(Duration(milliseconds: 1500));

    final currentContext = context;
    if (currentContext.mounted) {
      currentContext.go(redirectPath);
    }
  }
}
