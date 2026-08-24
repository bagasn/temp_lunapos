import 'package:drift/drift.dart';

@DataClassName('transactionLogs')
class TableTransactionLog extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get userName => text()();
  TextColumn get orderId => text()();
  TextColumn get orderNumber => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get dateTimeField => dateTime().named('dateTime')();
  TextColumn get description => text()();
  TextColumn get data1 => text()();
  TextColumn get data2 => text()();
  TextColumn get data3 => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
