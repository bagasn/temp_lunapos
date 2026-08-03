import 'package:drift/drift.dart';

@DataClassName('ModifierItem')
class TableModifierItem extends Table {
  @override
  String get tableName => 'modifierItems';

  TextColumn get id => text()();
  TextColumn get modifierId => text()();
  TextColumn get name => text()();
  TextColumn get productId => text()();
  TextColumn get productVariantId => text()();
  BoolColumn get useCustomPrice => boolean()();
  RealColumn get price => real()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();
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
