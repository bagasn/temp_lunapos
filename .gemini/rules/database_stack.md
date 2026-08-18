# Local Database Stack

The local database for this Flutter project is **Drift**. Firestore is still retained and used for certain cloud/remote features, but all local, offline-first data must be stored in Drift.

## Database Implementation Guidelines
1. **Multi-Database Support**: The app uses a multi-database architecture where each outlet or user may have their own database. Therefore, database connections MUST accept a dynamic `databaseName` parameter. Never hardcode the database name.
2. **Cross-Platform Readiness**: This project targets Web, Windows, Android, and iOS. You MUST configure Drift using conditional exports to support both Native (via `NativeDatabase` + `sqlite3_flutter_libs`) and Web (via `WasmDatabase`).
3. **Web Support (WasmDatabase)**: On the web platform, use `WasmDatabase.open` pointing to `sqlite3.wasm` and `drift_worker.dart.js`.
4. **Code Generation**: Use `build_runner` to generate Drift tables and DAOs.

## Connection Setup Reference
When creating the database connection, always use a multi-platform structure with conditional exports.

**1. Shared Interface (`connection.dart`)**
```dart
export 'connection_unsupported.dart'
  if (dart.library.ffi) 'connection_native.dart'
  if (dart.library.html) 'connection_web.dart';
```

**2. Web Implementation (`connection_web.dart`)**
```dart
import 'package:drift/wasm.dart';
import 'package:drift/drift.dart';

DatabaseConnection connectDatabase(String dbName) {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: dbName,
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      print('Using ${result.chosenImplementation} due to missing browser features: ${result.missingFeatures}');
    }
    return result.resolvedExecutor;
  }));
}
```

**3. Native Implementation (`connection_native.dart`)**
```dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

DatabaseConnection connectDatabase(String dbName) {
  return DatabaseConnection.delayed(Future(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, '$dbName.sqlite'));
    
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    
    return NativeDatabase.createInBackground(file);
  }));
}
```

## Database Architecture & App Database Manager

The application manages connections for three different local databases through `AppDatabaseManager` (`lib/core/database/app_database_manager.dart`). When designing or debugging schemas for these databases, you must refer to their corresponding files in the legacy `MiddleBackend` project (`/Users/jhonhell/Workspace/LunaProject/LunaPOS/luna-middle-backend-api`).

### 1. SettingDatabase
- **Purpose**: Stores User/Tenant data when the user logs in.
- **Reference**: `src/shared/database/setting-db-context.ts` in MiddleBackend.

### 2. MasterDatabase
- **Purpose**: A static database sourced from the application's assets. It is used to store static data to help application functionality.
- **Reference**: `src/shared/database/master-db-context.ts` in MiddleBackend.

### 3. MainDatabase
- **Purpose**: The primary database that stores data for Point-of-Sales needs.
- **Usage Constraints**:
  - It can only be used after the User/Tenant has completed the outlet login (2-step login process: normal username/password login -> select outlet).
  - This is a multi-database system. The connection to `MainDatabase` is done manually and depends on the outlet chosen by the user (a user can have more than one outlet).
- **Reference**: `src/shared/database/main-db-context.ts` in MiddleBackend.
