import 'package:drift/drift.dart';

@DataClassName('PriceLevelPriceList')
class TablePriceLevelPriceList extends Table {
  @override
  String get tableName => 'priceLevelPricelists';

  TextColumn get productId => text()();
  TextColumn get productVariantId => text()();
  TextColumn get priceLevelId => text()();
  TextColumn get priceLevelName => text()();
  RealColumn get price => real()();
  BoolColumn get isMaster => boolean()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
