import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class _Key {
  const _Key._();
  static const outletId = 'active_outlet_id';
  static const outletPosAuthKey = 'active_outlet_pos_auth_key';
  static const outletName = 'active_outlet_name';
  static const companyId = 'active_outlet_company_id';
  static const companyName = 'active_outlet_company_name';
  static const selectedOutletPictureUrl = 'active_outlet_picture_url';
}

@singleton
class ActiveOutletPreferences {
  final _prefs = SharedPreferencesAsync();

  Future<void> setActiveOutlet({
    required String outletId,
    required String posAuthKey,
    required String outletName,
    required String companyId,
    required String companyName,
    String? outletPictureUrl,
  }) async {
    await _prefs.setString(_Key.outletId, outletId);
    await _prefs.setString(_Key.outletPosAuthKey, posAuthKey);
    await _prefs.setString(_Key.outletName, outletName);
    await _prefs.setString(_Key.companyId, companyId);
    await _prefs.setString(_Key.companyName, companyName);

    if (outletPictureUrl != null) {
      await _prefs.setString(_Key.selectedOutletPictureUrl, outletPictureUrl);
    }
  }

  Future<void> clear() async {
    await _prefs.remove(_Key.outletId);
    await _prefs.remove(_Key.outletPosAuthKey);
    await _prefs.remove(_Key.outletName);
    await _prefs.remove(_Key.companyId);
    await _prefs.remove(_Key.companyName);
    await _prefs.remove(_Key.selectedOutletPictureUrl);
  }

  Future<bool> hasActiveOutlet() async {
    final id = await _prefs.getString(_Key.outletId);
    return id != null && id.isNotEmpty;
  }

  Future<String?> outletId() => _prefs.getString(_Key.outletId);

  Future<String?> outletName() => _prefs.getString(_Key.outletName);

  Future<String?> companyId() => _prefs.getString(_Key.companyId);

  Future<String?> companyName() => _prefs.getString(_Key.companyName);

  Future<String?> outletPosAuthKey() => _prefs.getString(_Key.outletPosAuthKey);

  Future<String?> selectedOutletPictureUrl() =>
      _prefs.getString(_Key.selectedOutletPictureUrl);
}
