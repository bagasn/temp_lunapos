import 'package:drift/drift.dart';

@DataClassName('priceTiers')
class TablePriceTier extends Table {
  @override
  String get tableName => 'priceTiers';

  TextColumn get id => text()();
  TextColumn get productId => text().nullable()();
  TextColumn get name => text().nullable()();
  RealColumn get minimumQty => real().nullable()();
  RealColumn get price => real().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
