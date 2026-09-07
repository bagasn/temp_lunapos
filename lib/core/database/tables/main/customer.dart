import 'package:drift/drift.dart';

@DataClassName('customers')
class TableCustomer extends Table {
  @override
  String get tableName => 'customers';

  TextColumn get id => text()();
  TextColumn get username => text().nullable()();
  TextColumn get displayName => text().nullable()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get company => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get gender => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get addressStreet1 => text().nullable()();
  TextColumn get addressCity => text().nullable()();
  TextColumn get addressStateProvince => text().nullable()();
  TextColumn get addressCountryId => text().nullable()();
  TextColumn get addressCountryName => text().nullable()();
  TextColumn get addressPostalCode => text().nullable()();
  TextColumn get bankAccountId => text().nullable()();
  TextColumn get bankId => text().nullable()();
  TextColumn get bankName => text().nullable()();
  TextColumn get bankAccountName => text().nullable()();
  TextColumn get bankAccountNumber => text().nullable()();
  TextColumn get pricingCategoryId => text().nullable()();
  BoolColumn get isSync => boolean().nullable()();
  DateTimeColumn get syncDate => dateTime().nullable()();
  TextColumn get createdByUserId => text().nullable()();
  DateTimeColumn get createdDateTime => dateTime().nullable()();
  TextColumn get lastUpdatedByUserId => text().nullable()();
  DateTimeColumn get lastUpdateDateTime => dateTime().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
