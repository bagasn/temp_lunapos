import 'package:drift/drift.dart';

@DataClassName('PromoProductVariantRewards')
class TablePromoProductVariantReward extends Table {
  @override
  String get tableName => 'promoProductVariantRewards';

  TextColumn get id => text()();
  TextColumn get promoId => text()();
  TextColumn get promoProductTRewardId => text()();
  TextColumn get productId => text().nullable()();
  TextColumn get productVariantId => text().nullable()();
  IntColumn get qty => integer().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
