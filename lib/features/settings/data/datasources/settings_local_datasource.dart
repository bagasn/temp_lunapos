import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class SettingsLocalDataSource {
  Future<bool> getAutoLockScreen();
  Future<void> updateAutoLockScreen(bool value);
}

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final AppDatabaseManager _dbManager;
  
  SettingsLocalDataSourceImpl(this._dbManager);

  @override
  Future<bool> getAutoLockScreen() async {
    final db = await _dbManager.mainDb;
    if (db == null) throw const CacheFailure('Database not initialized');
    
    final result = await db.select(db.tableOutletSetting).getSingleOrNull();
    return result?.autoLockScreen ?? true; // true is the default in TableOutletSetting
  }

  @override
  Future<void> updateAutoLockScreen(bool value) async {
    final db = await _dbManager.mainDb;
    if (db == null) throw const CacheFailure('Database not initialized');
    
    await db.update(db.tableOutletSetting).write(
      TableOutletSettingCompanion(autoLockScreen: Value(value)),
    );
  }
}
