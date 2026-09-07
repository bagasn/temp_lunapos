import 'package:drift/drift.dart';

@DataClassName('orderLineModifiers')
class TableOrderLineModifier extends Table {
  @override
  String get tableName => 'orderLineModifiers';

  TextColumn get id => text()();
  TextColumn get order => text()();
  TextColumn get orderId => text()();
  TextColumn get orderLine => text()();
  TextColumn get orderLineId => text()();
  TextColumn get modifier => text()();
  TextColumn get modifierId => text().nullable()();
  TextColumn get modifierItem => text()();
  TextColumn get modifierItemId => text().nullable()();
  TextColumn get modifierItemName => text().nullable()();
  TextColumn get product => text()();
  TextColumn get modifierItemProductId => text().nullable()();
  TextColumn get productVariant => text()();
  TextColumn get modifierItemProductVariantId => text().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get qty => real().nullable()();
  RealColumn get price => real().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
