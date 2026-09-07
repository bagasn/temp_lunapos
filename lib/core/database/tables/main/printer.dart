import 'package:drift/drift.dart';

@DataClassName('printers')
class TablePrinter extends Table {
  @override
  String get tableName => 'printers';

  TextColumn get id => text()();
  TextColumn get deviceId => text().nullable()();
  TextColumn get printerArea => text()();
  TextColumn get printerAreaId => text().nullable()();
  TextColumn get printerType => text().nullable()();
  TextColumn get printerModule => text().nullable()();
  TextColumn get printerConfig => text().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
