import 'package:drift/drift.dart';

@DataClassName('CouponOrders')
class TableCouponOrder extends Table {
  @override
  String get tableName => 'couponOrders';

  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get couponId => text()();
  TextColumn get couponCode => text().nullable()();
  TextColumn get couponName => text().nullable()();
  TextColumn get giftType => text().nullable()();
  TextColumn get discountType => text().nullable()();
  RealColumn get discountPercent => real().nullable()();
  RealColumn get discountAmount => real().nullable()();
  TextColumn get products => text().nullable()();
  TextColumn get savedByUserId => text().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
