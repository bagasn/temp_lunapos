import 'package:drift/drift.dart';

@DataClassName('Customer')
class TableCustomer extends Table {
  @override
  String get tableName => 'customers';

  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get displayName => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get company => text()();
  TextColumn get phone => text()();
  TextColumn get email => text()();
  TextColumn get gender => text()();
  DateTimeColumn get dateOfBirth => dateTime()();
  TextColumn get address => text()();
  TextColumn get addressStreet1 => text()();
  TextColumn get addressCity => text()();
  TextColumn get addressStateProvince => text()();
  TextColumn get addressCountryId => text()();
  TextColumn get addressCountryName => text()();
  TextColumn get addressPostalCode => text()();
  TextColumn get bankAccountId => text()();
  TextColumn get bankId => text()();
  TextColumn get bankName => text()();
  TextColumn get bankAccountName => text()();
  TextColumn get bankAccountNumber => text()();
  TextColumn get pricingCategoryId => text()();
  BoolColumn get isSync => boolean()();
  DateTimeColumn get syncDate => dateTime()();
  TextColumn get createdByUserId => text()();
  DateTimeColumn get createdDateTime => dateTime()();
  TextColumn get lastUpdatedByUserId => text()();
  DateTimeColumn get lastUpdateDateTime => dateTime()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
