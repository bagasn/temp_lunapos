import 'package:drift/drift.dart';

@DataClassName('orderMergeds')
class TableOrderMerged extends Table {
  TextColumn get orderId => text()();
  TextColumn get orderMergedId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
