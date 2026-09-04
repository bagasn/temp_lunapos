import 'package:drift/drift.dart';

@DataClassName('commissionToOrderLineRels')
class TableCommissionToOrderLine extends Table {
  @override
  String get tableName => 'commissionToOrderLineRels';

  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get orderLineId => text()();
  TextColumn get employeeId => text()();
  TextColumn get employeeName => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
