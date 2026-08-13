import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/local_storage/device_preferences.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/core/local_storage/setting_preferences.dart';
import 'package:pos/features/auth/select_outlet/domain/entities/auth_outlet_entity.dart';

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

  Future<void> setupOutletLogin({
    required String accessToken,
    required String refreshToken,
    required bool haveLunaone,
    required String? lunaoneToken,
    required String? lunaoneRefreshToken,
    required AuthOutletEntity selectedOutlet,
  }) async {
    await auth.saveOutletToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
      haveLunaone: haveLunaone,
      lunaoneToken: lunaoneToken,
      lunaoneRefreshToken: lunaoneRefreshToken,
    );
    await activeOutlet.setActiveOutlet(
      posAuthKey: selectedOutlet.posAuthKey,
      outletId: selectedOutlet.outletId,
      outletName: selectedOutlet.outletName,
      companyId: selectedOutlet.companyId,
      companyName: selectedOutlet.companyName,
      outletPictureUrl: selectedOutlet.outletPictureUrl,
    );
  }

  Future<bool> get isLoggedIn => auth.isLogged();

  Future<bool> get hasActiveOutlet => activeOutlet.hasActiveOutlet();

  Future<void> clearSession() async {
    await auth.clear();
    await activeOutlet.clear();
  }
}
