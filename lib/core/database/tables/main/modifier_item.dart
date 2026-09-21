import 'package:drift/drift.dart';

@DataClassName('ModifierItems')
class TableModifierItem extends Table {
  @override
  String get tableName => 'modifierItems';

  TextColumn get id => text()();
  TextColumn get modifierId => text()();
  TextColumn get name => text().nullable()();
  TextColumn get productId => text().nullable()();
  TextColumn get productVariantId => text().nullable()();
  BoolColumn get useCustomPrice => boolean().nullable()();
  RealColumn get price => real().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  TextColumn get modifier => text()();
  TextColumn get product => text()();
  TextColumn get productVariant => text()();
  TextColumn get prices => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
