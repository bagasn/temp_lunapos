import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class _Key {
  static const isLogged = 'auth_is_logged';
  static const userAccessToken = 'auth_user_access_token';
  static const userRefreshToken = 'auth_user_refresh_token';

  static const accessToken = 'auth_access_token';
  static const refreshToken = 'auth_refresh_token';
  static const lunaoneAccessToken = 'auth_lunaone_access_token';
  static const lunaoneRefreshToken = 'auth_lunaone_refresh_token';
}

@singleton
class AuthPreferences {
  final _prefs = SharedPreferencesAsync();

  Future<void> saveUserToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _prefs.setString(_Key.userAccessToken, accessToken);
    await _prefs.setString(_Key.userRefreshToken, refreshToken);
    await _prefs.setBool(_Key.isLogged, true);
  }

  Future<void> saveOutletToken({
    required String accessToken,
    required String refreshToken,
    required String? lunaoneToken,
    required String? lunaoneRefreshToken,
  }) async {
    await _prefs.setString(_Key.accessToken, accessToken);
    await _prefs.setString(_Key.refreshToken, refreshToken);
    if (lunaoneToken != null) {
      await _prefs.setString(_Key.lunaoneAccessToken, lunaoneToken);
    }
    if (lunaoneRefreshToken != null) {
      await _prefs.setString(_Key.lunaoneRefreshToken, lunaoneRefreshToken);
    }

    await _prefs.setBool(_Key.isLogged, true);
  }

  Future<void> clear() async {
    await _prefs.remove(_Key.isLogged);
    await _prefs.remove(_Key.accessToken);
    await _prefs.remove(_Key.refreshToken);
    await _prefs.remove(_Key.lunaoneAccessToken);
    await _prefs.remove(_Key.lunaoneRefreshToken);
    await _prefs.remove(_Key.userAccessToken);
    await _prefs.remove(_Key.userRefreshToken);
  }

  Future<bool> isLogged() async =>
      (await _prefs.getBool(_Key.isLogged)) ?? false;

  Future<String?> userAccessToken() => _prefs.getString(_Key.userAccessToken);

  Future<String?> userRefreshToken() => _prefs.getString(_Key.userRefreshToken);

  Future<String?> accesToken() => _prefs.getString(_Key.accessToken);

  Future<String?> refreshToken() => _prefs.getString(_Key.refreshToken);

  Future<String?> lunaoneAccessToken() =>
      _prefs.getString(_Key.lunaoneAccessToken);

  Future<String?> lunaoneRefreshToken() =>
      _prefs.getString(_Key.lunaoneRefreshToken);
}
