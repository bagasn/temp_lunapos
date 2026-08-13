import 'package:drift/drift.dart';

@DataClassName('ProductVariant')
class TableProductVariant extends Table {
  @override
  String get tableName => 'productVariants';

  TextColumn get id => text()();
  TextColumn get product => text()();
  TextColumn get productId => text()();
  TextColumn get sku => text()();
  TextColumn get name => text()();
  TextColumn get variantName => text()();
  RealColumn get unitPrice => real()();
  BoolColumn get isMaster => boolean()();
  TextColumn get attribute1Value => text()();
  TextColumn get attribute2Value => text()();
  TextColumn get attribute3Value => text()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();
  TextColumn get prices => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
