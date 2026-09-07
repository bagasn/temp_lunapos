import 'package:drift/drift.dart';

@DataClassName('orderLogs')
class TableOrderLog extends Table {
  @override
  String get tableName => 'orderLogs';

  TextColumn get id => text()();
  TextColumn get transactionId => text().nullable()();
  TextColumn get transactionNumber => text().nullable()();
  DateTimeColumn get transactionDate => dateTime().nullable()();
  TextColumn get receiptNumber => text().nullable()();
  TextColumn get customerId => text().nullable()();
  TextColumn get customerName => text().nullable()();
  TextColumn get salesTypeId => text().nullable()();
  TextColumn get tableId => text().nullable()();
  IntColumn get numberOfPax => integer().nullable()();
  TextColumn get productId => text().nullable()();
  TextColumn get productVariantId => text().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get qty => real().nullable()();
  IntColumn get unitPrice => integer().nullable()();
  IntColumn get totalLine => integer().nullable()();
  IntColumn get totalOrder => integer().nullable()();
  TextColumn get createdByUserId => text().nullable()();
  DateTimeColumn get createdDate => dateTime().nullable()();
  TextColumn get cancelledByUserId => text().nullable()();
  DateTimeColumn get cancellationDate => dateTime().nullable()();
  TextColumn get cancellationReason => text().nullable()();
  BoolColumn get isSync => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
