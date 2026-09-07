import 'package:drift/drift.dart';

@DataClassName('productVariants')
class TableProductVariant extends Table {
  @override
  String get tableName => 'productVariants';

  TextColumn get id => text()();
  TextColumn get product => text()();
  TextColumn get productId => text()();
  TextColumn get sku => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get variantName => text().nullable()();
  RealColumn get unitPrice => real().nullable()();
  BoolColumn get isMaster => boolean().nullable()();
  TextColumn get attribute1Value => text().nullable()();
  TextColumn get attribute2Value => text().nullable()();
  TextColumn get attribute3Value => text().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  TextColumn get prices => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
