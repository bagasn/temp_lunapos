import 'package:drift/drift.dart';

@DataClassName('qrisPaymentMethods')
class TableQrisPaymentMethod extends Table {
  @override
  String get tableName => 'qrisPaymentMethods';

  TextColumn get id => text()();
  TextColumn get id_transaction_pos => text()();
  TextColumn get createDateUtc => text()();
  TextColumn get updatedDateUtc => text()();
  TextColumn get name => text()();
  TextColumn get searchKey => text()();
  TextColumn get createUserId => text()();
  TextColumn get updateUserId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
