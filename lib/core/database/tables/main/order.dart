import 'package:drift/drift.dart';

@DataClassName('Orders')
class TableOrder extends Table {
  @override
  String get tableName => 'orders';

  TextColumn get id => text()();
  TextColumn get orderNumber => text().nullable()();
  TextColumn get orderName => text().nullable()();
  DateTimeColumn get orderDate => dateTime().nullable()();
  DateTimeColumn get orderDateTime => dateTime().nullable()();
  TextColumn get receiptNumber => text().nullable()();
  TextColumn get customer => text()();
  TextColumn get customerId => text().nullable()();
  TextColumn get customerName => text().nullable()();
  TextColumn get customerEmail => text().nullable()();
  TextColumn get customerPhone => text().nullable()();
  TextColumn get salesType => text()();
  TextColumn get salesTypeId => text().nullable()();
  TextColumn get promoSalesTypeId => text().nullable()();
  TextColumn get table => text()();
  TextColumn get tableId => text().nullable()();
  IntColumn get numberOfPax => integer().nullable()();
  BoolColumn get taxInclusive => boolean().nullable()();
  IntColumn get lineCount => integer().nullable()();
  RealColumn get lineTotalQty => real().nullable()();
  RealColumn get lineTotalDiscountAmount => real().withDefault(const Constant(0))();
  RealColumn get subTotal => real().nullable()();
  TextColumn get discountId => text().nullable()();
  TextColumn get discount => text()();
  RealColumn get discountPercent => real().nullable()();
  RealColumn get discountAmount => real().nullable()();
  TextColumn get discountLoyaltyId => text().nullable()();
  TextColumn get discountLoyaltyName => text().nullable()();
  RealColumn get discountLoyaltyPercent => real().nullable()();
  RealColumn get discountLoyaltyAmount => real().nullable()();
  TextColumn get discountLoyaltyDescription => text().nullable()();
  TextColumn get membershipProgramId => text().nullable()();
  TextColumn get membershipLevelId => text().nullable()();
  TextColumn get membershipDiscountId => text().nullable()();
  RealColumn get membershipDiscountPercent => real().nullable()();
  RealColumn get membershipDiscountAmount => real().nullable()();
  RealColumn get qponCoupon => real().nullable()();
  RealColumn get qponVoucher => real().nullable()();
  BoolColumn get serviceCharged => boolean().nullable()();
  RealColumn get serviceChargeRate => real().nullable()();
  RealColumn get serviceChargeAmount => real().nullable()();
  TextColumn get serviceChargeTax => text()();
  TextColumn get serviceChargeTaxId => text().nullable()();
  RealColumn get serviceChargeTaxRate => real().nullable()();
  BoolColumn get taxed => boolean().nullable()();
  RealColumn get taxAmount => real().nullable()();
  RealColumn get adjustmentAmount => real().nullable()();
  RealColumn get total => real().nullable()();
  RealColumn get tenderAmount => real().nullable()();
  RealColumn get changeAmount => real().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get createdByUser => text()();
  TextColumn get createdByUserId => text().nullable()();
  DateTimeColumn get createdDateTime => dateTime().nullable()();
  TextColumn get lastUpdateByUserId => text().nullable()();
  DateTimeColumn get lastUpdateDateTime => dateTime().nullable()();
  TextColumn get paidByUser => text()();
  TextColumn get paidByUserId => text().nullable()();
  DateTimeColumn get paymentDate => dateTime().nullable()();
  DateTimeColumn get paymentDateTime => dateTime().nullable()();
  TextColumn get cancelledByUser => text()();
  TextColumn get cancelledByUserId => text().nullable()();
  DateTimeColumn get cancellationDate => dateTime().nullable()();
  DateTimeColumn get cancellationDateTime => dateTime().nullable()();
  TextColumn get cancellationReason => text().nullable()();
  DateTimeColumn get closingDate => dateTime().nullable()();
  DateTimeColumn get closingDateTime => dateTime().nullable()();
  TextColumn get rowVersion => text().nullable()();
  BoolColumn get isSync => boolean().nullable()();
  DateTimeColumn get syncDate => dateTime().nullable()();
  BoolColumn get isInvalid => boolean().nullable()();
  BoolColumn get isTokolunaOrder => boolean().withDefault(const Constant(false))();
  IntColumn get printBillCount => integer().withDefault(const Constant(0))();
  BoolColumn get afterClose => boolean().withDefault(const Constant(false))();
  IntColumn get queueNumber => integer().nullable()();
  TextColumn get shiftSessionId => text().nullable()();
  IntColumn get type => integer().nullable()();
  IntColumn get service => integer().nullable()();
  TextColumn get lines => text()();
  TextColumn get payments => text()();
  TextColumn get taxes => text()();
  TextColumn get coupon => text()();
  TextColumn get linkedOrder => text()();
  TextColumn get oppoCouponList => text()();
  TextColumn get session => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
