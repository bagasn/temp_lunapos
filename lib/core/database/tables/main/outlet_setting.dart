import 'package:drift/drift.dart';

@DataClassName('OutletSettings')
class TableOutletSetting extends Table {
  @override
  String get tableName => 'outletSettings';

  TextColumn get defaultSalesTaxId => text().nullable()();
  IntColumn get id => integer()();
  TextColumn get lastLoginUser => text()();
  TextColumn get lastLoginUserId => text()();
  IntColumn get lastOrderNumber => integer().nullable()();
  DateTimeColumn get lastOrderNumberDate => dateTime().nullable()();
  BoolColumn get serviceCharged => boolean().nullable()();
  RealColumn get serviceChargeRate => real().nullable()();
  TextColumn get serviceChargeTax => text()();
  TextColumn get serviceChargeTaxId => text().nullable()();
  RealColumn get serviceChargeTaxRate => real().nullable()();
  BoolColumn get serviceChargeBeforeDiscount => boolean().nullable()();
  BoolColumn get taxed => boolean().nullable()();
  BoolColumn get taxInclusive => boolean().nullable()();
  BoolColumn get taxOnSales => boolean().nullable()();
  BoolColumn get taxOnDiscount =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSyncTime => dateTime().nullable()();
  BoolColumn get autoPrint => boolean().nullable()();
  BoolColumn get printCaptainOrder => boolean().nullable()();
  BoolColumn get copyCaptainOrder => boolean().nullable()();
  IntColumn get qtyCaptainOrder =>
      integer().withDefault(const Constant(1))();
  BoolColumn get copyReceipt => boolean().nullable()();
  IntColumn get qtyReceipt =>
      integer().withDefault(const Constant(1))();
  BoolColumn get autoLockScreen =>
      boolean().withDefault(const Constant(true))();
  TextColumn get address => text().nullable()();
  TextColumn get pinPoint => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get fax => text().nullable()();
  TextColumn get facebook => text().nullable()();
  TextColumn get instagram => text().nullable()();
  TextColumn get twitter => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get billNotes => text().nullable()();
  TextColumn get closingTime => text().nullable()();
  TextColumn get pictureUrl => text().nullable()();
  TextColumn get pictureLocal => text().nullable()();
  BoolColumn get requiredOrderName =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get requiredShift =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get allowCustomPriceOrDiscount =>
      boolean().withDefault(const Constant(false))();
  IntColumn get lastQueueNumber => integer().nullable()();
  DateTimeColumn get lastQueueNumberDate => dateTime().nullable()();
  IntColumn get maxQueueNumber =>
      integer().withDefault(const Constant(50))();
  BoolColumn get useQueue =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get hideFinalCashEndShift =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get useDefaultItemNotes =>
      boolean().withDefault(const Constant(false))();
  TextColumn get defaultItemNotes => text().nullable()();
  BoolColumn get isSyncOpenOrder => boolean().nullable()();
  BoolColumn get isCanSaveOrder =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isCanPaymentCash =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isSppMode =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get requiredTable =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get cleanEndShift =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get useRounding =>
      boolean().withDefault(const Constant(false))();
  IntColumn get roundingType =>
      integer().withDefault(const Constant(0))();
  IntColumn get roundingBase =>
      integer().withDefault(const Constant(500))();
  DateTimeColumn get subscriptionDueDateUtc => dateTime().nullable()();
  TextColumn get defaultWarehouseId => text().nullable()();
  BoolColumn get enableStockPreview =>
      boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
