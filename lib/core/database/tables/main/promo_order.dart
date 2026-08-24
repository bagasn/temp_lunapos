import 'package:drift/drift.dart';

@DataClassName('promoOrders')
class TablePromoOrder extends Table {
  TextColumn get promoId => text()();
  TextColumn get orderId => text()();
  TextColumn get promoName => text()();
  RealColumn get promoType => real()();
  RealColumn get totalPromoAmountLines => real()();
  RealColumn get qty => real()();
  DateTimeColumn get createDateUtc => dateTime()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
