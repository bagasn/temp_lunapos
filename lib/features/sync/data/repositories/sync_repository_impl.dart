import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/features/sync/data/datasources/sync_data_service.dart';
import 'package:pos/features/sync/domain/repositories/sync_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  final SyncDataService _syncService;
  final SessionManager _session;
  final AppDatabaseManager _databaseManager;

  SyncRepositoryImpl(this._syncService, this._session, this._databaseManager);

  Future<Either<Failure, bool>> getInitialData() async {
    try {
      final posResult = await _syncService.getInitialData();

      final database = await _databaseManager.mainDb;
      if (database != null) {
        // TODO: Insert data to database
      } else {
        throw DatabaseFailure('Main Database not found');
      }

      return right(true);
    } on DatabaseFailure catch (error) {
      return left(error);
    } catch (error, stackTrace) {
      return left(NetworkFailure.error(error, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, bool>> getInitialDataProduct() async {
    try {
      final productResult = await _syncService.getInitialProduct();

      final database = await _databaseManager.mainDb;
      if (database != null) {
        // TODO: Insert data to database
      } else {
        throw DatabaseFailure('Main Database not found');
      }
      return right(true);
    } on DatabaseFailure catch (error) {
      return left(error);
    } catch (error, stackTrace) {
      return left(NetworkFailure.error(error, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, bool>> getInitialDataPromo() async {
    try {
      final promoResult = await _syncService.getInitialPromo();

      final database = await _databaseManager.mainDb;
      if (database != null) {
        // TODO: Insert data to database
      } else {
        throw DatabaseFailure('Main Database not found');
      }
      return right(true);
    } on DatabaseFailure catch (error) {
      return left(error);
    } catch (error, stackTrace) {
      return left(NetworkFailure.error(error, stackTrace: stackTrace));
    }
  }
}
