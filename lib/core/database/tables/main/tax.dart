import 'package:drift/drift.dart';

@DataClassName('taxes')
class TableTax extends Table {
  @override
  String get tableName => 'taxes';

  TextColumn get id => text()();
  TextColumn get code => text().nullable()();
  TextColumn get name => text().nullable()();
  RealColumn get rate => real().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  TextColumn get products => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
