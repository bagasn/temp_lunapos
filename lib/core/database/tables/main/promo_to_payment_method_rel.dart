import 'package:drift/drift.dart';

@DataClassName('promoToPaymentMethodRels')
class TablePromoToPaymentMethodRel extends Table {
  TextColumn get id => text()();
  TextColumn get promoId => text()();
  TextColumn get paymentMethodId => text()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
