import 'package:drift/drift.dart';

@DataClassName('printoutTemplates')
class TablePrintoutTemplate extends Table {
  @override
  String get tableName => 'printoutTemplates';

  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get showLogo => boolean()();
  BoolColumn get showOrderNumber => boolean()();
  BoolColumn get showDate => boolean()();
  BoolColumn get showAddress => boolean()();
  BoolColumn get showAdjustment => boolean()();
  BoolColumn get showTax => boolean()();
  BoolColumn get showServiceCharge => boolean()();
  BoolColumn get showUnitPriceProduct => boolean()();
  BoolColumn get showUnitPriceModifier => boolean()();
  RealColumn get sortOrder => real()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
