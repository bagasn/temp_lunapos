import 'package:drift/drift.dart';

@DataClassName('PromoOrders')
class TablePromoOrder extends Table {
  @override
  String get tableName => 'promoOrders';

  TextColumn get promoId => text()();
  TextColumn get orderId => text()();
  TextColumn get promoName => text().nullable()();
  IntColumn get promoType => integer().nullable()();
  IntColumn get totalPromoAmountLines => integer().nullable()();
  IntColumn get qty => integer().nullable()();
  DateTimeColumn get createDateUtc => dateTime().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
