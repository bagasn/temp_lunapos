import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/local_storage/device_preferences.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/core/local_storage/setting_preferences.dart';
import 'package:pos/features/auth/shared/data/models/token_response.dart';

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

  Future<void> setupUserLogin(TokenResponse data) async {
    await auth.saveOutletToken(
      accessToken: data.accessToken,
      refreshToken: data.refreshToken,
      lunaoneToken: data.tokenLunaone,
      lunaoneRefreshToken: data.refreshTokenLunaone,
    );
  }

  Future<bool> get isLoggedIn => auth.isLogged();

  Future<bool> get hasOutletSelected => activeOutlet.hasActiveOutlet();

  Future<void> clearSession() async {
    await auth.clear();
    await activeOutlet.clear();
    await setting.clear();
  }
}
