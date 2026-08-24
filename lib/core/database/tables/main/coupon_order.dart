import 'package:drift/drift.dart';

@DataClassName('couponOrders')
class TableCouponOrder extends Table {
  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get couponId => text()();
  TextColumn get couponCode => text()();
  TextColumn get couponName => text()();
  TextColumn get giftType => text()();
  TextColumn get discountType => text()();
  RealColumn get discountPercent => real()();
  RealColumn get discountAmount => real()();
  TextColumn get products => text()();
  TextColumn get savedByUserId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
