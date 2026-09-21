import 'package:drift/drift.dart';

@DataClassName('PromoProductRewards')
class TablePromoProductReward extends Table {
  @override
  String get tableName => 'promoProductRewards';

  TextColumn get id => text()();
  TextColumn get promoId => text()();
  TextColumn get productId => text().nullable()();
  BoolColumn get allVariants => boolean().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
