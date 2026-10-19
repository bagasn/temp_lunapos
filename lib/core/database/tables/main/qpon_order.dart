import 'package:drift/drift.dart';

@DataClassName('QponOrders')
class TableQponOrder extends Table {
  @override
  String get tableName => 'qponOrders';

  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get couponId => text().nullable()();
  TextColumn get couponType => text().nullable()();
  RealColumn get couponAmount => real().nullable()();
  RealColumn get minimumAmountLimit => real().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
