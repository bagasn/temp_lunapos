import 'package:drift/drift.dart';

@DataClassName('PromoToSalesTypeRel')
class TablePromoToSalesTypeRel extends Table {
  @override
  String get tableName => 'promoToSalesTypeRels';

  TextColumn get id => text()();
  TextColumn get promoId => text()();
  TextColumn get salesTypeId => text()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
