import 'package:drift/drift.dart';

@DataClassName('QrisPaymentMethods')
class TableQrisPaymentMethod extends Table {
  @override
  String get tableName => 'qrisPaymentMethods';

  TextColumn get id => text()();
  TextColumn get idTransactionPos => text()();
  DateTimeColumn get createDateUtc => dateTime().nullable()();
  TextColumn get updatedDateUtc => text()();
  TextColumn get name => text().nullable()();
  TextColumn get searchKey => text().nullable()();
  TextColumn get createUserId => text().nullable()();
  TextColumn get updateUserId => text().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
