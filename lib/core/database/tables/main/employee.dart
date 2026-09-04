import 'package:drift/drift.dart';

@DataClassName('employees')
class TableEmployee extends Table {
  @override
  String get tableName => 'employees';

  TextColumn get id => text()();
  TextColumn get name => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
