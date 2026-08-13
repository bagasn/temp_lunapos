import 'package:drift/drift.dart';

@DataClassName('PromoProductVariantReward')
class TablePromoProductVariantReward extends Table {
  @override
  String get tableName => 'promoProductVariantRewards';

  TextColumn get id => text()();
  TextColumn get promoId => text()();
  TextColumn get promoProductTRewardId => text()();
  TextColumn get productId => text()();
  TextColumn get productVariantId => text()();
  RealColumn get qty => real()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
