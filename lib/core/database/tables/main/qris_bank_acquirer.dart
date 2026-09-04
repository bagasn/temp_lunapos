import 'package:drift/drift.dart';

@DataClassName('qrisBankAcquirers')
class TableQrisBankAcquirer extends Table {
  @override
  String get tableName => 'qrisBankAcquirers';

  TextColumn get id => text()();
  TextColumn get id_transaction_pos => text()();
  DateTimeColumn get createdDateUtc => dateTime()();
  DateTimeColumn get updatedDateUtc => dateTime()();
  TextColumn get name => text()();
  TextColumn get searchKey => text()();
  TextColumn get settlementBankName => text()();
  TextColumn get settlementBankAccountNumber => text()();
  TextColumn get createUserId => text()();
  TextColumn get updateUserId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
