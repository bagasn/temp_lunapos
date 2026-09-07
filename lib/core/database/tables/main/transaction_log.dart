import 'package:drift/drift.dart';

@DataClassName('transactionLogs')
class TableTransactionLog extends Table {
  @override
  String get tableName => 'transactionLogs';

  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get userName => text().nullable()();
  TextColumn get orderId => text().nullable()();
  TextColumn get orderNumber => text().nullable()();
  DateTimeColumn get date => dateTime().nullable()();
  DateTimeColumn get dateTimeField => dateTime().named('dateTime')();
  TextColumn get description => text().nullable()();
  TextColumn get data1 => text().nullable()();
  TextColumn get data2 => text().nullable()();
  TextColumn get data3 => text().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
