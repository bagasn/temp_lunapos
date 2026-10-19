import 'package:drift/drift.dart';

@DataClassName('PromoExtensions')
class TablePromoExtension extends Table {
  @override
  String get tableName => 'promoExtensions';

  TextColumn get id => text()();
  TextColumn get promoId => text()();
  TextColumn get operatorTerm => text().nullable()();
  TextColumn get operatorReward => text().nullable()();
  IntColumn get termVariantLength => integer().nullable()();
  IntColumn get discountType => integer().nullable()();
  RealColumn get discountPercentage => real().nullable()();
  RealColumn get discountAmount => real().nullable()();
  RealColumn get maxDiscountAmount => real().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
