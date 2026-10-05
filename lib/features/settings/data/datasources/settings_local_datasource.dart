import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/core/local_storage/setting_preferences.dart';
import 'package:pos/features/settings/domain/entities/setting_order_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class SettingsLocalDataSource {
  Future<bool> getAutoLockScreen();
  Future<void> updateAutoLockScreen(bool value);
  Future<SettingOrderEntity> getOrderSettings();
  Future<void> updateOrderSettings(SettingOrderEntity settings);
}

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final AppDatabaseManager _dbManager;
  final SettingPreferences _preferences;

  SettingsLocalDataSourceImpl(this._dbManager, this._preferences);

  @override
  Future<bool> getAutoLockScreen() async {
    final db = await _dbManager.mainDb;
    if (db == null) throw const CacheFailure('Database not initialized');

    final result = await db.select(db.tableOutletSetting).getSingleOrNull();
    return result?.autoLockScreen ?? true;
  }

  @override
  Future<void> updateAutoLockScreen(bool value) async {
    final db = await _dbManager.mainDb;
    if (db == null) throw const CacheFailure('Database not initialized');

    await db.update(db.tableOutletSetting).write(
      TableOutletSettingCompanion(autoLockScreen: Value(value)),
    );
  }

  @override
  Future<SettingOrderEntity> getOrderSettings() async {
    final db = await _dbManager.mainDb;
    if (db == null) throw const CacheFailure('Database not initialized');

    final row = await db.select(db.tableOutletSetting).getSingleOrNull();
    final defaultView = await _preferences.getOrderView();

    return SettingOrderEntity(
      defaultView: defaultView,
      // requiredOrderName -> customerRequired
      customerRequired: row?.requiredOrderName ?? false,
      // requiredShift -> shiftSessionRequired
      shiftSessionRequired: row?.requiredShift ?? false,
      // hideFinalCashEndShift is stored as INVERSE of showCashDetail
      showCashDetail: !(row?.hideFinalCashEndShift ?? false),
      // useRounding -> roundOrderTotal
      roundOrderTotal: row?.useRounding ?? false,
      roundingType: row?.roundingType ?? 0,
      roundingBase: row?.roundingBase ?? 500,
      // useQueue -> queueNumbering
      queueNumbering: row?.useQueue ?? false,
      maxQueueNumber: row?.maxQueueNumber ?? 50,
      lastQueueNumber: row?.lastQueueNumber,
      // useDefaultItemNotes -> addCustomNotes
      addCustomNotes: row?.useDefaultItemNotes ?? false,
      // printCaptainOrder -> printKitchenSeparately
      printKitchenSeparately: row?.printCaptainOrder ?? false,
      // isSyncOpenOrder -> syncOpenOrder
      syncOpenOrder: row?.isSyncOpenOrder ?? false,
      // isCanPaymentCash -> cashPayment
      cashPayment: row?.isCanPaymentCash ?? true,
      // isCanSaveOrder -> allowSavingOrders
      allowSavingOrders: row?.isCanSaveOrder ?? true,
      // cleanEndShift -> endingShiftNotAllowed
      endingShiftNotAllowed: row?.cleanEndShift ?? false,
      // requiredTable -> tableSelectionRequired
      tableSelectionRequired: row?.requiredTable ?? false,
      // enableStockPreview -> showStock
      showStock: row?.enableStockPreview ?? false,
    );
  }

  @override
  Future<void> updateOrderSettings(SettingOrderEntity settings) async {
    final db = await _dbManager.mainDb;
    if (db == null) throw const CacheFailure('Database not initialized');

    // Persist defaultView (int) to shared preferences
    await _preferences.setOrderView(settings.defaultView);

    // Persist the 13 booleans to the database
    await db.update(db.tableOutletSetting).write(
      TableOutletSettingCompanion(
        requiredOrderName: Value(settings.customerRequired),
        requiredShift: Value(settings.shiftSessionRequired),
        // showCashDetail is the INVERSE of hideFinalCashEndShift
        hideFinalCashEndShift: Value(!settings.showCashDetail),
        useRounding: Value(settings.roundOrderTotal),
        roundingType: Value(settings.roundingType),
        roundingBase: Value(settings.roundingBase),
        useQueue: Value(settings.queueNumbering),
        maxQueueNumber: Value(settings.maxQueueNumber),
        // lastQueueNumber is a runtime counter owned by the order flow,
        // so it is intentionally NOT written here.
        useDefaultItemNotes: Value(settings.addCustomNotes),
        printCaptainOrder: Value(settings.printKitchenSeparately),
        isSyncOpenOrder: Value(settings.syncOpenOrder),
        isCanPaymentCash: Value(settings.cashPayment),
        isCanSaveOrder: Value(settings.allowSavingOrders),
        cleanEndShift: Value(settings.endingShiftNotAllowed),
        requiredTable: Value(settings.tableSelectionRequired),
        enableStockPreview: Value(settings.showStock),
      ),
    );
  }
}
