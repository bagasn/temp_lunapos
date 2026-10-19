import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/local_storage/device_preferences.dart';

class DeviceIdHelper {
  static Future<String> getDeviceId() =>
      locator<DevicePreferences>().getOrCreateDeviceId();
}
