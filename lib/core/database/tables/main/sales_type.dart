import 'package:drift/drift.dart';

@DataClassName('salesTypes')
class TableSalesType extends Table {
  @override
  String get tableName => 'salesTypes';

  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get serviceCharged => boolean()();
  BoolColumn get taxed => boolean()();
  BoolColumn get isMaster => boolean()();
  BoolColumn get deleted => boolean()();
  TextColumn get priceLevelId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
