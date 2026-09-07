import 'package:drift/drift.dart';

@DataClassName('productModifierRelations')
class TableProductModifierRelation extends Table {
  @override
  String get tableName => 'productModifierRelations';

  TextColumn get productId => text()();
  TextColumn get modifierId => text()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  TextColumn get product => text()();
  TextColumn get modifier => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
