import 'package:drift/drift.dart';

DatabaseConnection connectDatabase(String dbName) {
  throw UnsupportedError(
    'No suitable database implementation was found on this platform.',
  );
}
