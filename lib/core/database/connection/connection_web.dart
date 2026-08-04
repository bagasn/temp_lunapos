import 'package:drift/wasm.dart';
import 'package:drift/drift.dart';

DatabaseConnection connectDatabase(String dbName) {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: dbName,
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      print('Using ${result.chosenImplementation} due to missing browser features: ${result.missingFeatures}');
    }
    return result.resolvedExecutor;
  }));
}
