import 'package:injectable/injectable.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/local_storage/device_preferences.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/core/local_storage/setting_preferences.dart';

@singleton
class SessionManager {
  final AuthPreferences auth;
  final OutletPreferences outlet;
  final SettingPreferences setting;
  final DevicePreferences device;

  SessionManager({
    required this.auth,
    required this.outlet,
    required this.setting,
    required this.device,
  });

  Future<bool> get isLoggedIn => auth.isLogged();
  Future<bool> get hasOutletSelected => outlet.hasSelectedOutlet();

  Future<void> clearSession() async {
    await auth.clear();
    await outlet.clear();
    await setting.clear();
  }
}
