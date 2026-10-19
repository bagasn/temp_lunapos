import 'package:drift/drift.dart';

@DataClassName('PriceLevelPricelists')
class TablePriceLevelPriceList extends Table {
  @override
  String get tableName => 'priceLevelPricelists';

  TextColumn get productId => text()();
  TextColumn get productVariantId => text()();
  TextColumn get priceLevelId => text()();
  TextColumn get priceLevelName => text().nullable()();
  RealColumn get price => real().nullable()();
  BoolColumn get isMaster => boolean().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
