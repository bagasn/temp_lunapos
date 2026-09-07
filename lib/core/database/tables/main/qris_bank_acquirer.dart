import 'package:drift/drift.dart';

@DataClassName('qrisBankAcquirers')
class TableQrisBankAcquirer extends Table {
  @override
  String get tableName => 'qrisBankAcquirers';

  TextColumn get id => text()();
  TextColumn get id_transaction_pos => text()();
  DateTimeColumn get createdDateUtc => dateTime()();
  DateTimeColumn get updatedDateUtc => dateTime().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get searchKey => text().nullable()();
  TextColumn get settlementBankName => text()();
  TextColumn get settlementBankAccountNumber => text().nullable()();
  TextColumn get createUserId => text().nullable()();
  TextColumn get updateUserId => text().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
