import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/core/local_storage/session_manager.dart';
import 'package:pos/features/sync/data/datasources/sync_data_service.dart';
import 'package:pos/features/sync/data/models/payload/sync_payload.dart';
import 'package:pos/features/sync/data/models/response/initial_data_response.dart';
import 'package:pos/features/sync/domain/models/sync_entity.dart';
import 'package:pos/features/sync/domain/repositories/sync_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:pos/shared/utilities/log_util.dart';

@LazySingleton(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  final SyncDataService _syncService;
  final SessionManager _session;
  final AppDatabaseManager _databaseManager;

  SyncRepositoryImpl(this._syncService, this._session, this._databaseManager);

  Future<Either<Failure, SyncEntity>> getInitialData(
    SyncEntity params, {
    String? serverTime,
  }) async {
    try {
      final outletFuture = _syncService.getInitialData(
        SyncPayload(serverTime: serverTime),
      );
      // final productFuture = _syncService.getInitialProduct(
      //   SyncPayload(serverTime: serverTime),
      // );
      // final promoFuture = _syncService.getInitialPromo(
      //   SyncPayload(serverTime: serverTime),
      // );

      // final (outletResult, productResult, promoResult) = await (
      //   outletFuture,
      //   productFuture,
      //   promoFuture,
      // ).wait;

      final outletResult = await outletFuture;

      final database = await _databaseManager.mainDb;
      if (database == null) {
        throw DatabaseFailure('No connection to database has found!');
      }

      _saveSyncOutlet(database, outletResult);

      return right(
        SyncEntity(
          outletId: params.outletId,
          companyId: params.companyId,
          outletSynced: false,
          productSynced: false,
          promoSynced: false,
        ),
      );
    } on DatabaseFailure catch (error) {
      return left(error);
    } catch (error, stackTrace) {
      return left(NetworkFailure.error(error, stackTrace: stackTrace));
    }
  }
}

Future<bool> _saveSyncOutlet(
  MainDatabase database,
  InitialDataResponse data,
) async {
  try {
    final customerInsert = <TableCustomerCompanion>[];
    for (final item in data.customers) {
      // final insert = TableCustomerCompanion.insert(
      //   id: item.id,
      //   username: null,
      //   displayName: item.displayName,
      //   firstName: item.firstName,
      //   lastName: item.lastName,
      //   company: company,
      //   phone: phone,
      //   email: email,
      //   gender: gender,
      //   dateOfBirth: dateOfBirth,
      //   address: address,
      //   addressStreet1: addressStreet1,
      //   addressCity: addressCity,
      //   addressStateProvince: addressStateProvince,
      //   addressCountryId: addressCountryId,
      //   addressCountryName: addressCountryName,
      //   addressPostalCode: addressPostalCode,
      //   bankAccountId: bankAccountId,
      //   bankId: bankId,
      //   bankName: bankName,
      //   bankAccountName: bankAccountName,
      //   bankAccountNumber: bankAccountNumber,
      //   pricingCategoryId: pricingCategoryId,
      //   isSync: isSync,
      //   syncDate: syncDate,
      //   createdByUserId: createdByUserId,
      //   createdDateTime: createdDateTime,
      //   lastUpdatedByUserId: lastUpdatedByUserId,
      //   lastUpdateDateTime: lastUpdateDateTime,
      //   deleted: deleted,
      // );

      // customerInsert.add(insert);
    }

    database.tableCustomer.insertAll([]);
  } catch (error, stackTrace) {
    LogUtil.e(error.toString(), stackTrace: stackTrace);
    rethrow;
  }

  return true;
}
