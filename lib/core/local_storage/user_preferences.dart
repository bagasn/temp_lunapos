import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class _KEY {
  static const String userId = 'pos_user_id';
  static const String userFirstName = 'pos_user_first_name';
  static const String userLastName = 'pos_user_last_name';
  static const String userFullName = 'pos_user_full_name';
}

@singleton
class ActiveUserPreferences {
  final _prefs = SharedPreferencesAsync();

  Future<void> setActiveUser({
    required String userId,
    required String userFirstName,
    required String userLastName,
    required String userFullName,
  }) async {
    await _prefs.setString(_KEY.userId, userId);
    await _prefs.setString(_KEY.userFirstName, userFirstName);
    await _prefs.setString(_KEY.userLastName, userLastName);
    await _prefs.setString(_KEY.userFullName, userFullName);
  }

  Future<bool> hasActiveUser() async {
    final id = await _prefs.getString(_KEY.userId);
    return id != null && id.isNotEmpty;
  }
}
