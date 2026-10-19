import 'package:drift/drift.dart';

@DataClassName('PrinterAreaRels')
class TablePrinterAreaRel extends Table {
  @override
  String get tableName => 'printerAreaRels';

  TextColumn get productId => text()();
  TextColumn get printerAreaId => text()();
  TextColumn get printerItemAreaId => text()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
