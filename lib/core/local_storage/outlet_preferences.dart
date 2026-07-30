import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class _Key {
  const _Key._();
  static const selectedOutletId = 'outlet_selected_id';
  static const selectedOutletName = 'outlet_selected_name';
  static const selectedCompanyName = 'outlet_selected_company_name';
  static const selectedPosAuthKey = 'outlet_selected_pos_auth_key';
  static const selectedOutletPictureUrl = 'outlet_selected_picture_url';
}

@singleton
class OutletPreferences {
  final _prefs = SharedPreferencesAsync();

  Future<void> saveSelectedOutlet({
    required String outletId,
    required String outletName,
    required String companyName,
    required String posAuthKey,
    String? outletPictureUrl,
  }) async {
    await _prefs.setString(_Key.selectedOutletId, outletId);
    await _prefs.setString(_Key.selectedOutletName, outletName);
    await _prefs.setString(_Key.selectedCompanyName, companyName);
    await _prefs.setString(_Key.selectedPosAuthKey, posAuthKey);
    if (outletPictureUrl != null) {
      await _prefs.setString(_Key.selectedOutletPictureUrl, outletPictureUrl);
    }
  }

  Future<void> clear() async {
    await _prefs.remove(_Key.selectedOutletId);
    await _prefs.remove(_Key.selectedOutletName);
    await _prefs.remove(_Key.selectedCompanyName);
    await _prefs.remove(_Key.selectedPosAuthKey);
    await _prefs.remove(_Key.selectedOutletPictureUrl);
  }

  Future<bool> hasSelectedOutlet() async {
    final id = await _prefs.getString(_Key.selectedOutletId);
    return id != null && id.isNotEmpty;
  }

  Future<String?> selectedOutletId() =>
      _prefs.getString(_Key.selectedOutletId);

  Future<String?> selectedOutletName() =>
      _prefs.getString(_Key.selectedOutletName);

  Future<String?> selectedCompanyName() =>
      _prefs.getString(_Key.selectedCompanyName);

  Future<String?> selectedPosAuthKey() =>
      _prefs.getString(_Key.selectedPosAuthKey);

  Future<String?> selectedOutletPictureUrl() =>
      _prefs.getString(_Key.selectedOutletPictureUrl);
}
