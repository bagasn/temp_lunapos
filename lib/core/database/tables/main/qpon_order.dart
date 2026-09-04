import 'package:drift/drift.dart';

@DataClassName('qponOrders')
class TableQponOrder extends Table {
  @override
  String get tableName => 'qponOrders';

  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get couponId => text()();
  TextColumn get couponType => text()();
  RealColumn get couponAmount => real()();
  RealColumn get minimumAmountLimit => real()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
