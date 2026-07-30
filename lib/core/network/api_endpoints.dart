import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static String get baseUrlAuth => dotenv.get('BASEURL_AUTH');
  static String get baseUrlPos => dotenv.get('BASEURL_POS');
  static String get baseUrlMain => dotenv.get('BASEURL_MAIN');
  static String get appVersion => dotenv.get('APP_VERSION', fallback: '1.0.0');

  // Auth
  static const String token = '/token';

  // POS
  static const String outlet = '/outlet';
  static const String posInitialData = '/pos/initial-data';

  // Main
  static const String posInvoice = '/pos/invoice';
}
