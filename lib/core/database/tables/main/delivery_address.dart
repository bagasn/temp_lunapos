import 'package:drift/drift.dart';

@DataClassName('deliveryAddresses')
class TableDeliveryAddress extends Table {
  @override
  String get tableName => 'deliveryAddresses';

  TextColumn get id => text()();
  TextColumn get deliveryId => text()();
  RealColumn get party => real()();
  TextColumn get label => text()();
  TextColumn get name => text()();
  TextColumn get phoneNumber => text()();
  BoolColumn get pinPoint => boolean()();
  TextColumn get longitude => text()();
  TextColumn get latitude => text()();
  TextColumn get address => text()();
  RealColumn get provinceId => real()();
  TextColumn get provinceName => text()();
  RealColumn get cityId => real()();
  TextColumn get cityName => text()();
  RealColumn get districtId => real()();
  TextColumn get districtName => text()();
  RealColumn get villageId => real()();
  TextColumn get villageName => text()();
  TextColumn get postalCode => text()();
  TextColumn get notes => text()();
  BoolColumn get isMainAddress => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
