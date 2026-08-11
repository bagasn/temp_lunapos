import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

DatabaseConnection connectDatabase(String dbName) {
  return DatabaseConnection.delayed(
    Future(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      if (!await dbFolder.exists()) {
        await dbFolder.create(recursive: true);
      }

      final localDbFile = File(p.join(dbFolder.path, '$dbName.sqlite'));

      // Also work around limitations on old Android versions
      if (Platform.isAndroid) {
        // await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return DatabaseConnection(
        NativeDatabase.createInBackground(
          localDbFile,
          logStatements: false, // kDebugMode,
        ),
      );
    }),
  );
}
