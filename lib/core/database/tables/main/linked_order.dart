import 'package:drift/drift.dart';

@DataClassName('linkedOrders')
class TableLinkedOrder extends Table {
  @override
  String get tableName => 'linkedOrders';

  TextColumn get orderId => text()();
  IntColumn get qrDuration => integer().nullable()();
  TextColumn get categoryIds => text().nullable()();
  DateTimeColumn get orderDate => dateTime().nullable()();
  DateTimeColumn get orderTime => dateTime().nullable()();
  IntColumn get status => integer().withDefault(const Constant(0))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
