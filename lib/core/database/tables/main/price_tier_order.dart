import 'package:drift/drift.dart';

@DataClassName('priceTierOrderLines')
class TablePriceTierOrderLine extends Table {
  @override
  String get tableName => 'priceTierOrderLines';

  TextColumn get priceTierId => text()();
  TextColumn get orderId => text()();
  TextColumn get orderLineId => text()();
  TextColumn get productId => text()();
  TextColumn get id => text()();
  TextColumn get priceTierName => text().nullable()();
  RealColumn get minimumQty => real().nullable()();
  RealColumn get price => real().nullable()();
  RealColumn get originalPrice => real().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  DateTimeColumn get createDateUtc => dateTime().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
