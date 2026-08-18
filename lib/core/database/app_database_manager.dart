import 'package:injectable/injectable.dart';
import 'package:pos/core/database/master_database.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/core/database/setting_database.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/utilities/log_util.dart';

@singleton
class AppDatabaseManager {
  final ActiveOutletPreferences _outletSession;

  AppDatabaseManager(this._outletSession);

  SettingDatabase? _settingDb;
  MasterDatabase? _masterDb;
  MainDatabase? _mainDb;

  SettingDatabase get systemDb {
    return _settingDb ??= SettingDatabase();
  }

  MasterDatabase get masterDb {
    return _masterDb ??= MasterDatabase();
  }

  Future<MainDatabase?> get mainDb async {
    if (_mainDb != null) {
      return _mainDb!;
    }
    if (!await _outletSession.hasActiveOutlet()) {
      return null;
    }

    final tenantId = await _outletSession.companyId();
    final outletId = await _outletSession.outletId();

    if (tenantId == null || outletId == null) {
      throw ServerFailure('Cannot find active outlet.');
    }

    await openMainDatabase(tenantId: tenantId, outletId: outletId);
    return _mainDb;
  }

  Future<bool> openMainDatabase({
    required int tenantId,
    required int outletId,
  }) async {
    try {
      await _mainDb?.close();
      final dbName = '${tenantId}_$outletId';
      _mainDb = MainDatabase(dbName);
      return true;
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), error: error, stackTrace: stackTrace);
      return false;
    }
  }

  Future<void> closeMainDatabase() async {
    await _mainDb?.close();
    _mainDb = null;
  }
}
