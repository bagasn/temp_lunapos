import 'package:drift/drift.dart';

@DataClassName('ProductCategoryRelations')
class TableProductCategoryRelation extends Table {
  @override
  String get tableName => 'productCategoryRelations';

  TextColumn get productId => text()();
  TextColumn get categoryId => text()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  TextColumn get product => text()();
  TextColumn get category => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
