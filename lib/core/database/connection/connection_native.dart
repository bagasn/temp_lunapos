import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:pos/shared/utilities/log_util.dart';
import 'package:sqlite3/sqlite3.dart';

DatabaseConnection connectDatabase(String dbName, {bool fromAssets = false}) {
  return DatabaseConnection.delayed(
    Future(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      if (!await dbFolder.exists()) {
        await dbFolder.create(recursive: true);
      }

      final localDbFile = File(p.join(dbFolder.path, '$dbName.sqlite'));

      if (fromAssets) {
        try {
          final blob = await rootBundle.load('assets/databases/$dbName');
          final buffer = blob.buffer;

          await localDbFile.writeAsBytes(
            buffer.asInt8List(blob.offsetInBytes, blob.lengthInBytes),
            flush: true,
          );

          LogUtil.i(
            'Successfully coping database $dbName from assets to application storage',
          );
        } catch (error, stackTrace) {
          LogUtil.e(error.toString(), error: error, stackTrace: stackTrace);
        }
      }

      // Also work around limitations on old Android versions
      if (Platform.isAndroid) {
        // await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return DatabaseConnection(
        NativeDatabase.createInBackground(
          localDbFile,
          logStatements: kDebugMode, // kDebugMode,
        ),
      );
    }),
  );
}
