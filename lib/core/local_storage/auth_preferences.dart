import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class _Key {
  const _Key._();
  static const isLogged = 'auth_is_logged';
  static const userAccessToken = 'auth_user_access_token';
  static const userRefreshToken = 'auth_user_refresh_token';
  static const outletAccessToken = 'auth_outlet_access_token';
  static const outletRefreshToken = 'auth_outlet_refresh_token';
  static const companyId = 'auth_company_id';
  static const outletId = 'auth_outlet_id';
  static const outletName = 'auth_outlet_name';
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
  }

  Future<void> saveOutletToken({
    required String accessToken,
    required String refreshToken,
    required String companyId,
    required String outletId,
    required String outletName,
  }) async {
    await _prefs.setString(_Key.outletAccessToken, accessToken);
    await _prefs.setString(_Key.outletRefreshToken, refreshToken);
    await _prefs.setString(_Key.companyId, companyId);
    await _prefs.setString(_Key.outletId, outletId);
    await _prefs.setString(_Key.outletName, outletName);
    await _prefs.setBool(_Key.isLogged, true);
  }

  Future<void> clear() async {
    await _prefs.remove(_Key.isLogged);
    await _prefs.remove(_Key.userAccessToken);
    await _prefs.remove(_Key.userRefreshToken);
    await _prefs.remove(_Key.outletAccessToken);
    await _prefs.remove(_Key.outletRefreshToken);
    await _prefs.remove(_Key.companyId);
    await _prefs.remove(_Key.outletId);
    await _prefs.remove(_Key.outletName);
  }

  Future<bool> isLogged() async =>
      (await _prefs.getBool(_Key.isLogged)) ?? false;

  Future<String?> userAccessToken() =>
      _prefs.getString(_Key.userAccessToken);

  Future<String?> outletAccessToken() =>
      _prefs.getString(_Key.outletAccessToken);

  Future<String?> outletRefreshToken() =>
      _prefs.getString(_Key.outletRefreshToken);

  Future<String?> companyId() => _prefs.getString(_Key.companyId);

  Future<String?> outletId() => _prefs.getString(_Key.outletId);

  Future<String?> outletName() => _prefs.getString(_Key.outletName);
}
