import 'package:drift/drift.dart';

DatabaseConnection connectDatabase(String dbName, {bool fromAssets = false}) {
  throw UnsupportedError(
    'No suitable database implementation was found on this platform.',
  );
}
