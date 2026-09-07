import 'package:drift/drift.dart';

@DataClassName('salesTypes')
class TableSalesType extends Table {
  @override
  String get tableName => 'salesTypes';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  BoolColumn get serviceCharged => boolean().withDefault(const Constant(false))();
  BoolColumn get taxed => boolean().withDefault(const Constant(false))();
  BoolColumn get isMaster => boolean().withDefault(const Constant(false))();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  TextColumn get priceLevelId => text().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
