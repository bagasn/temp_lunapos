import 'package:drift/drift.dart';

@DataClassName('PriceLevel')
class TablePriceLevel extends Table {
  @override
  String get tableName => 'pricelevels';

  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get isMaster => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
