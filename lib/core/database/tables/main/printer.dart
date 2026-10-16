import 'package:drift/drift.dart';

@DataClassName('Printers')
class TablePrinter extends Table {
  @override
  String get tableName => 'printers';

  TextColumn get id => text()();
  TextColumn get printerAreaId => text()();
  TextColumn get printerType => text()();
  TextColumn get printerModule => text()();
  TextColumn get printerConfig => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
