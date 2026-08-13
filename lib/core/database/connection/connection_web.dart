import 'package:drift/wasm.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:pos/shared/utilities/log_util.dart';

DatabaseConnection connectDatabase(String dbName, {bool fromAssets = false}) {
  return DatabaseConnection.delayed(
    Future(() async {
      final result = await WasmDatabase.open(
        databaseName: dbName,
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
        initializeDatabase: fromAssets
            ? () async {
                final data = await rootBundle.load('assets/databases/$dbName');
                return data.buffer.asUint8List();
              }
            : null,
      );

      if (result.missingFeatures.isNotEmpty) {
        LogUtil.e(
          'Using ${result.chosenImplementation} due to missing browser features: ${result.missingFeatures}',
        );
      }
      return result.resolvedExecutor;
    }),
  );
}
