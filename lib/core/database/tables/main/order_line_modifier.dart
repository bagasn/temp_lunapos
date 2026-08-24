import 'package:drift/drift.dart';

@DataClassName('orderLineModifiers')
class TableOrderLineModifier extends Table {
  TextColumn get id => text()();
  TextColumn get order => text()();
  TextColumn get orderId => text()();
  TextColumn get orderLine => text()();
  TextColumn get orderLineId => text()();
  TextColumn get modifier => text()();
  TextColumn get modifierId => text()();
  TextColumn get modifierItem => text()();
  TextColumn get modifierItemId => text()();
  TextColumn get modifierItemName => text()();
  TextColumn get product => text()();
  TextColumn get modifierItemProductId => text()();
  TextColumn get productVariant => text()();
  TextColumn get modifierItemProductVariantId => text()();
  TextColumn get description => text()();
  RealColumn get qty => real()();
  RealColumn get price => real()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
