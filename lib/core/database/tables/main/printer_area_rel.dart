import 'package:drift/drift.dart';

@DataClassName('printerAreaRels')
class TablePrinterAreaRel extends Table {
  @override
  String get tableName => 'printerAreaRels';

  TextColumn get productId => text()();
  TextColumn get printerAreaId => text()();
  RealColumn get sortOrder => real()();
  TextColumn get products => text()();
  TextColumn get printers => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
