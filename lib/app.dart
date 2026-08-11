import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/core/navigation/app_router.dart';
import 'package:pos/core/theme/app_theme.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';

class LunaposApp extends StatefulWidget {
  const LunaposApp({super.key});

  @override
  State<LunaposApp> createState() => _LunaposAppState();
}

class _LunaposAppState extends State<LunaposApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter(locator<SessionManager>());
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: ToastificationWrapper(
        config: ToastificationConfig(
          alignment: Alignment.topCenter,
          maxToastLimit: 1,
          animationDuration: Duration(milliseconds: 200),
        ),
        child: MaterialApp.router(
          title: 'Luna POS',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id'), // Indonesian
            Locale('en'), // English
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) return const Locale('id');
            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
            return const Locale('id');
          },
        ),
      ),
    );
  }
}
