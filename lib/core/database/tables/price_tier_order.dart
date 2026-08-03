import 'package:drift/drift.dart';

@DataClassName('PriceTierOrderLine')
class TablePriceTierOrderLine extends Table {
  @override
  String get tableName => 'priceTiers';

  TextColumn get priceTierId => text()();
  TextColumn get orderId => text()();
  TextColumn get orderLineId => text()();
  TextColumn get productId => text()();
  TextColumn get id => text()();
  TextColumn get priceTierName => text()();
  RealColumn get minimumQty => real()();
  RealColumn get price => real()();
  DateTimeColumn get createDateUtc => dateTime()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
