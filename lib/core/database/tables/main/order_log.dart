import 'package:drift/drift.dart';

@DataClassName('orderLogs')
class TableOrderLog extends Table {
  @override
  String get tableName => 'orderLogs';

  TextColumn get id => text()();
  TextColumn get transactionId => text()();
  TextColumn get transactionNumber => text()();
  TextColumn get transactionDate => text()();
  TextColumn get receiptNumber => text()();
  TextColumn get customerId => text()();
  TextColumn get customerName => text()();
  TextColumn get salesTypeId => text()();
  TextColumn get tableId => text()();
  RealColumn get numberOfPax => real()();
  TextColumn get productId => text()();
  TextColumn get productVariantId => text()();
  TextColumn get description => text()();
  RealColumn get qty => real()();
  RealColumn get unitPrice => real()();
  RealColumn get totalLine => real()();
  RealColumn get totalOrder => real()();
  TextColumn get createdByUserId => text()();
  TextColumn get createdDate => text()();
  TextColumn get cancelledByUserId => text()();
  TextColumn get cancellationDate => text()();
  TextColumn get cancellationReason => text()();
  BoolColumn get isSync => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
