import 'package:drift/drift.dart';

@DataClassName('PrinterAreas')
class TablePrinterArea extends Table {
  @override
  String get tableName => 'printerAreas';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => textEnum<PrinterAreaType>()();
  IntColumn get sortOrder => integer()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

enum PrinterAreaType { primary, optional }
