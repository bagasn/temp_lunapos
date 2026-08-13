import 'package:injectable/injectable.dart';
import 'package:pos/core/database/master_database.dart';
import 'package:pos/core/database/pos_database.dart';
import 'package:pos/core/database/system_database.dart';
import 'package:pos/core/local_storage/outlet_preferences.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/utilities/log_util.dart';

@singleton
class AppDatabaseManager {
  final ActiveOutletPreferences _outletSession;

  AppDatabaseManager(this._outletSession);

  SystemDatabase? _systemDb;
  MasterDatabase? _masterDb;
  PosDatabase? _posDb;

  SystemDatabase get systemDb {
    return _systemDb ??= SystemDatabase();
  }

  MasterDatabase get masterDb {
    return _masterDb ??= MasterDatabase();
  }

  Future<PosDatabase?> get posDb async {
    if (_posDb != null) {
      return _posDb!;
    }
    if (!await _outletSession.hasActiveOutlet()) {
      return null;
    }

    final tenantId = await _outletSession.companyId();
    final outletId = await _outletSession.outletId();

    if (tenantId == null || outletId == null) {
      throw ServerFailure('Cannot find active outlet.');
    }

    await openPosDatabase(tenantId: tenantId, outletId: outletId);
    return _posDb;
  }

  Future<bool> openPosDatabase({
    required int tenantId,
    required int outletId,
  }) async {
    try {
      await _posDb?.close();
      final dbName = '${tenantId}_$outletId';
      _posDb = PosDatabase(dbName);
      return true;
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), error: error, stackTrace: stackTrace);
      return false;
    }
  }

  Future<void> close() async {
    await _posDb?.close();
    _posDb = null;
  }
}
