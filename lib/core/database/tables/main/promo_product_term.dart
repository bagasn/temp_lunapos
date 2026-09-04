import 'package:drift/drift.dart';

@DataClassName('promoProductTerms')
class TablePromoProductTerm extends Table {
  @override
  String get tableName => 'promoProductTerms';

  TextColumn get id => text()();
  TextColumn get promoId => text()();
  TextColumn get productId => text()();
  BoolColumn get allVariants => boolean()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
