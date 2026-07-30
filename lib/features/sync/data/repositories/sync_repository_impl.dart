import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/firestore/firestore_paths.dart';
import 'package:pos/core/firestore/firestore_service.dart';
import 'package:pos/core/local_storage/auth_preferences.dart';
import 'package:pos/core/local_storage/device_preferences.dart';
import 'package:pos/core/local_storage/setting_preferences.dart';
import 'package:pos/features/sync/data/datasources/sync_remote_datasource.dart';
import 'package:pos/features/sync/domain/repositories/sync_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';

@LazySingleton(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  final SyncRemoteDatasource _datasource;
  final FirestoreService _firestoreService;
  final AuthPreferences _authPrefs;
  final SettingPreferences _settingPrefs;
  final DevicePreferences _devicePrefs;

  SyncRepositoryImpl(
    this._datasource,
    this._firestoreService,
    this._authPrefs,
    this._settingPrefs,
    this._devicePrefs,
  );

  @override
  Future<Either<Failure, String>> executeSync({bool force = false}) async {
    try {
      final outletId = await _authPrefs.outletId() ?? '';
      final deviceId = await _devicePrefs.getOrCreateDeviceId();

      String? serverTime;
      if (!force) {
        serverTime = await _settingPrefs.getLastSyncTime();
      }

      final syncData = await _datasource.fetchInitialData(
        serverTime: serverTime,
      );

      await _writeToFirestore(syncData, outletId, deviceId);

      if (syncData.serverTime != null) {
        await _settingPrefs.setLastSyncTime(syncData.serverTime!);
      }

      return const Right('Sync complete');
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Network error during sync'));
    } catch (e) {
      return Left(UnknownFailure('Sync error: $e'));
    }
  }

  Future<void> _writeToFirestore(
    dynamic syncData,
    String outletId,
    String deviceId,
  ) async {
    final writes = <Future<void>>[];

    if (syncData.products?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.products(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.products!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.categories?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.categories(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.categories!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.modifiers?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.modifiers(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.modifiers!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.modifierItems?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.modifierItems(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.modifierItems!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.paymentMethods?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.paymentMethods(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.paymentMethods!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.salesTypes?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.salesTypes(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.salesTypes!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.taxes?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.taxes(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.taxes!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.discounts?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.discounts(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.discounts!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.customers?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.customers(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.customers!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.tables?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.tables(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.tables!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.areas?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.areas(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.areas!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.priceList?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.priceLists(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.priceList!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.productToCategories?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.productToCategories(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.productToCategories!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.productToModifiers?.isNotEmpty == true) {
      writes.add(_firestoreService.batchUpsert(
        collectionPath: FirestorePaths.productToModifiers(outletId, deviceId),
        documents: List<Map<String, dynamic>>.from(syncData.productToModifiers!),
        idExtractor: (d) => d['id']?.toString() ?? '',
      ));
    }

    if (syncData.outletSetting != null) {
      writes.add(_firestoreService.setDocument(
        FirestorePaths.outletSetting(outletId, deviceId),
        'info',
        syncData.outletSetting as Map<String, dynamic>,
      ));
    }

    // Update sync metadata
    writes.add(_firestoreService.setDocument(
      FirestorePaths.syncInfo(outletId, deviceId),
      'metadata',
      {
        'lastSyncTime': FieldValue.serverTimestamp(),
        'serverTime': syncData.serverTime,
        'appVersion': '1.0.0',
      },
    ));

    await Future.wait(writes);
  }
}
