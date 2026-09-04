import 'package:drift/drift.dart';

@DataClassName('linkedOrders')
class TableLinkedOrder extends Table {
  @override
  String get tableName => 'linkedOrders';

  TextColumn get orderId => text()();
  RealColumn get qrDuration => real()();
  TextColumn get categoryIds => text()();
  DateTimeColumn get orderDate => dateTime()();
  DateTimeColumn get orderTime => dateTime()();
  RealColumn get status => real()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
