import 'package:drift/drift.dart';

@DataClassName('Deliveries')
class TableDelivery extends Table {
  @override
  String get tableName => 'deliveries';

  TextColumn get id => text()();
  TextColumn get orderId => text().nullable()();
  TextColumn get awbNumber => text().nullable()();
  TextColumn get logisticName => text().nullable()();
  TextColumn get serviceType => text().nullable()();
  IntColumn get qty => integer().nullable()();
  BoolColumn get isUseInsurance => boolean().withDefault(const Constant(false))();
  RealColumn get insurancePrice => real().nullable()();
  RealColumn get shipmentPrice => real().nullable()();
  BoolColumn get isPickup => boolean().withDefault(const Constant(false))();
  BoolColumn get isCod => boolean().withDefault(const Constant(false))();
  RealColumn get codPrice => real().nullable()();
  TextColumn get shippingNote => text().nullable()();
  TextColumn get rateCode => text().nullable()();
  IntColumn get packageQty => integer().nullable()();
  RealColumn get packagePrice => real().nullable()();
  TextColumn get packageDescription => text().nullable()();
  TextColumn get packageDimensions => text().nullable()();
  RealColumn get packageWeight => real().nullable()();
  TextColumn get deliveryAddress => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
