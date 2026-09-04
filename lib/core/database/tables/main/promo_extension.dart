import 'package:drift/drift.dart';

@DataClassName('promoExtensions')
class TablePromoExtension extends Table {
  @override
  String get tableName => 'promoExtensions';

  TextColumn get id => text()();
  TextColumn get promoId => text()();
  TextColumn get operatorTerm => text()();
  TextColumn get operatorReward => text()();
  RealColumn get termVariantLength => real()();
  RealColumn get discountType => real()();
  BoolColumn get discountPercentage => boolean()();
  BoolColumn get discountAmount => boolean()();
  BoolColumn get maxDiscountAmount => boolean()();
  BoolColumn get sortOrder => boolean()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
