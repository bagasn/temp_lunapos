import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/local_storage/device_preferences.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/core/local_storage/setting_preferences.dart';
import 'package:pos/shared/data/response/token_response.dart';

@singleton
class SessionManager {
  final AuthPreferences auth;
  final ActiveOutletPreferences activeOutlet;
  final SettingPreferences setting;
  final DevicePreferences device;

  SessionManager({
    required this.auth,
    required this.activeOutlet,
    required this.setting,
    required this.device,
  });

  Future<void> setupUserLogin({
    required String userAccessToken,
    required String userRefreshToken,
  }) async {
    await auth.saveUserToken(
      accessToken: userAccessToken,
      refreshToken: userRefreshToken,
    );

    await activeOutlet.clear();
  }

  Future<bool> get isLoggedIn => auth.isLogged();

  Future<bool> get hasActiveOutlet => activeOutlet.hasActiveOutlet();

  Future<void> clearSession() async {
    await auth.clear();
    await activeOutlet.clear();
  }
}
