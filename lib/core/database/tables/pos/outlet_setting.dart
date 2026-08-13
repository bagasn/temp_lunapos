import 'package:drift/drift.dart';

@DataClassName('OutletSetting')
class TableOutletSetting extends Table {
  TextColumn get defaultSalesTaxId => text().nullable()();
  RealColumn get id => real()();
  TextColumn get lastLoginUser => text()();
  TextColumn get lastLoginUserId => text()();
  RealColumn get lastOrderNumber => real()();
  DateTimeColumn get lastOrderNumberDate => dateTime()();
  BoolColumn get serviceCharged => boolean()();
  RealColumn get serviceChargeRate => real()();
  TextColumn get serviceChargeTax => text()();
  TextColumn get serviceChargeTaxId => text()();
  RealColumn get serviceChargeTaxRate => real()();
  BoolColumn get serviceChargeBeforeDiscount => boolean()();
  BoolColumn get taxed => boolean()();
  BoolColumn get taxInclusive => boolean()();
  BoolColumn get taxOnSales => boolean()();
  BoolColumn get taxOnDiscount => boolean()();
  TextColumn get lastSyncTime => text()();
  BoolColumn get autoPrint => boolean()();
  BoolColumn get printCaptainOrder => boolean()();
  BoolColumn get copyCaptainOrder => boolean()();
  RealColumn get qtyCaptainOrder => real()();
  BoolColumn get copyReceipt => boolean()();
  RealColumn get qtyReceipt => real()();
  BoolColumn get autoLockScreen => boolean()();
  TextColumn get address => text()();
  TextColumn get pinPoint => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get fax => text()();
  TextColumn get facebook => text()();
  TextColumn get instagram => text()();
  TextColumn get twitter => text()();
  TextColumn get website => text()();
  TextColumn get billNotes => text()();
  TextColumn get closingTime => text()();
  TextColumn get pictureUrl => text()();
  TextColumn get pictureLocal => text()();
  BoolColumn get requiredOrderName => boolean()();
  BoolColumn get requiredShift => boolean()();
  BoolColumn get allowCustomPriceOrDiscount => boolean()();
  RealColumn get lastQueueNumber => real()();
  DateTimeColumn get lastQueueNumberDate => dateTime()();
  RealColumn get maxQueueNumber => real()();
  BoolColumn get useQueue => boolean()();
  BoolColumn get hideFinalCashEndShift => boolean()();
  BoolColumn get useDefaultItemNotes => boolean()();
  TextColumn get defaultItemNotes => text()();
  BoolColumn get isSyncOpenOrder => boolean()();
  BoolColumn get isCanSaveOrder => boolean()();
  BoolColumn get isCanPaymentCash => boolean()();
  BoolColumn get isSppMode => boolean()();
  BoolColumn get requiredTable => boolean()();
  BoolColumn get cleanEndShift => boolean()();
  BoolColumn get useRounding => boolean()();
  RealColumn get roundingType => real()();
  RealColumn get roundingBase => real()();
  DateTimeColumn get subscriptionDueDateUtc => dateTime()();
  TextColumn get defaultWarehouseId => text()();
  BoolColumn get enableStockPreview => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
