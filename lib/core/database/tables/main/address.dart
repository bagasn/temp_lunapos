import 'package:drift/drift.dart';

@DataClassName('addresses')
class TableAddress extends Table {
  TextColumn get id => text()();
  TextColumn get customerId => text()();
  TextColumn get label => text()();
  TextColumn get address => text()();
  TextColumn get street => text()();
  RealColumn get villageId => real()();
  TextColumn get village => text()();
  RealColumn get districtId => real()();
  TextColumn get district => text()();
  RealColumn get cityId => real()();
  TextColumn get city => text()();
  RealColumn get provinceId => real()();
  TextColumn get province => text()();
  TextColumn get countryId => text()();
  TextColumn get countryName => text()();
  TextColumn get postalCode => text()();
  TextColumn get recipientName => text()();
  TextColumn get recipientPhone => text()();
  TextColumn get source => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
