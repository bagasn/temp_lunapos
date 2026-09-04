import 'package:drift/drift.dart';

@DataClassName('pricelists')
class TableProductPricelist extends Table {
  @override
  String get tableName => 'pricelists';

  TextColumn get productId => text()();
  TextColumn get productVariantId => text()();
  TextColumn get salesTypeId => text()();
  TextColumn get salesTypeName => text()();
  RealColumn get price => real()();
  BoolColumn get isMaster => boolean()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
