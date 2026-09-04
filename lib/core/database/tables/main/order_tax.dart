import 'package:drift/drift.dart';

@DataClassName('orderTaxes')
class TableOrderTax extends Table {
  @override
  String get tableName => 'orderTaxes';

  TextColumn get order => text()();
  TextColumn get orderId => text()();
  TextColumn get taxId => text()();
  RealColumn get taxRate => real()();
  RealColumn get baseAmount => real()();
  RealColumn get taxAmount => real()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
