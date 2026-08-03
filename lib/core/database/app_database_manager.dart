import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database.dart';

@singleton
class AppDatabaseManager {
  AppDatabase? _currentDb;

  AppDatabase get database {
    if (_currentDb == null) throw Exception('Database not opened yet.');
    return _currentDb!;
  }

  Future<bool> openDatabase({required String tenantId, required String outletId}) async {
    try {
      await _currentDb?.close();
      final dbName = '${tenantId}_$outletId';
      _currentDb = AppDatabase(dbName);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> close() async {
    await _currentDb?.close();
    _currentDb = null;
  }
}
