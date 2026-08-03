import 'package:drift/drift.dart';

@DataClassName('Printer')
class TablePrinter extends Table {
  TextColumn get id => text()();
  TextColumn get deviceId => text()();
  TextColumn get printerArea => text()();
  TextColumn get printerAreaId => text()();
  TextColumn get printerType => text()();
  TextColumn get printerModule => text()();
  TextColumn get printerConfig => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
