import 'package:drift/drift.dart';

@DataClassName('priceTiers')
class TablePriceTier extends Table {
  @override
  String get tableName => 'priceTiers';

  TextColumn get id => text()();
  TextColumn get productId => text()();
  TextColumn get name => text()();
  RealColumn get minimumQty => real()();
  RealColumn get price => real()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
