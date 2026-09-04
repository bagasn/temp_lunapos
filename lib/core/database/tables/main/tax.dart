import 'package:drift/drift.dart';

@DataClassName('taxes')
class TableTax extends Table {
  @override
  String get tableName => 'taxes';

  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  RealColumn get rate => real()();
  BoolColumn get deleted => boolean()();
  TextColumn get products => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
