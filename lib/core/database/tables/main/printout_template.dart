import 'package:drift/drift.dart';

@DataClassName('printoutTemplates')
class TablePrintoutTemplate extends Table {
  @override
  String get tableName => 'printoutTemplates';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  BoolColumn get showLogo => boolean().withDefault(const Constant(true))();
  BoolColumn get showOrderNumber => boolean().withDefault(const Constant(true))();
  BoolColumn get showDate => boolean().withDefault(const Constant(true))();
  BoolColumn get showAddress => boolean().withDefault(const Constant(true))();
  BoolColumn get showAdjustment => boolean().withDefault(const Constant(true))();
  BoolColumn get showTax => boolean().withDefault(const Constant(true))();
  BoolColumn get showServiceCharge => boolean().withDefault(const Constant(true))();
  BoolColumn get showUnitPriceProduct => boolean().withDefault(const Constant(true))();
  BoolColumn get showUnitPriceModifier => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
