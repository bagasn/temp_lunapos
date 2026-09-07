import 'package:drift/drift.dart';

@DataClassName('deliveryAddresses')
class TableDeliveryAddress extends Table {
  @override
  String get tableName => 'deliveryAddresses';

  TextColumn get id => text()();
  TextColumn get deliveryId => text()();
  RealColumn get party => real()();
  TextColumn get label => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  BoolColumn get pinPoint => boolean().nullable()();
  TextColumn get longitude => text().nullable()();
  TextColumn get latitude => text().nullable()();
  TextColumn get address => text().nullable()();
  IntColumn get provinceId => integer().nullable()();
  TextColumn get provinceName => text().nullable()();
  IntColumn get cityId => integer().nullable()();
  TextColumn get cityName => text().nullable()();
  IntColumn get districtId => integer().nullable()();
  TextColumn get districtName => text().nullable()();
  IntColumn get villageId => integer().nullable()();
  TextColumn get villageName => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isMainAddress => boolean().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
