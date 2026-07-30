import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class _Key {
  const _Key._();
  static const locale = 'setting_locale';
  static const lastSyncTime = 'setting_last_sync_time';
}

@singleton
class SettingPreferences {
  final _prefs = SharedPreferencesAsync();

  Future<void> setLocale(String locale) =>
      _prefs.setString(_Key.locale, locale);

  Future<String?> getLocale() => _prefs.getString(_Key.locale);

  Future<void> setLastSyncTime(String isoTime) =>
      _prefs.setString(_Key.lastSyncTime, isoTime);

  Future<String?> getLastSyncTime() =>
      _prefs.getString(_Key.lastSyncTime);

  Future<void> clear() async {
    await _prefs.remove(_Key.lastSyncTime);
  }
}
