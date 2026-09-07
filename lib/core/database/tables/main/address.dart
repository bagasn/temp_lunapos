import 'package:drift/drift.dart';

@DataClassName('addresses')
class TableAddress extends Table {
  @override
  String get tableName => 'addresses';

  TextColumn get id => text()();
  TextColumn get customerId => text()();
  TextColumn get label => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get street => text().nullable()();
  IntColumn get villageId => integer().nullable()();
  TextColumn get village => text().nullable()();
  IntColumn get districtId => integer().nullable()();
  TextColumn get district => text().nullable()();
  IntColumn get cityId => integer().nullable()();
  TextColumn get city => text().nullable()();
  IntColumn get provinceId => integer().nullable()();
  TextColumn get province => text().nullable()();
  TextColumn get countryId => text().nullable()();
  TextColumn get countryName => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get recipientName => text().nullable()();
  TextColumn get recipientPhone => text().nullable()();
  TextColumn get source => text().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
