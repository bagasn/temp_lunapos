import 'package:drift/drift.dart';

@DataClassName('deliveries')
class TableDelivery extends Table {
  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get awbNumber => text()();
  TextColumn get logisticName => text()();
  TextColumn get serviceType => text()();
  RealColumn get qty => real()();
  BoolColumn get isUseInsurance => boolean()();
  RealColumn get insurancePrice => real()();
  RealColumn get shipmentPrice => real()();
  BoolColumn get isPickup => boolean()();
  BoolColumn get isCod => boolean()();
  RealColumn get codPrice => real()();
  TextColumn get shippingNote => text()();
  TextColumn get rateCode => text()();
  RealColumn get packageQty => real()();
  RealColumn get packagePrice => real()();
  TextColumn get packageDescription => text()();
  TextColumn get packageDimensions => text()();
  RealColumn get packageWeight => real()();
  TextColumn get deliveryAddress => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
