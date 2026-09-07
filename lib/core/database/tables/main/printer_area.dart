import 'package:drift/drift.dart';

@DataClassName('printerAreas')
class TablePrinterArea extends Table {
  @override
  String get tableName => 'printerAreas';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  TextColumn get products => text()();
  TextColumn get printers => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
