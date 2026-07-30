import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final class _Key {
  const _Key._();
  static const deviceId = 'device_unique_id';
}

@singleton
class DevicePreferences {
  final _prefs = SharedPreferencesAsync();

  Future<String> getOrCreateDeviceId() async {
    var id = await _prefs.getString(_Key.deviceId);
    if (id == null || id.isEmpty) {
      id = const Uuid().v4();
      await _prefs.setString(_Key.deviceId, id);
    }
    return id;
  }
}
