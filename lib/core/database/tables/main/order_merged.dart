import 'package:drift/drift.dart';

@DataClassName('orderMergeds')
class TableOrderMerged extends Table {
  @override
  String get tableName => 'orderMergeds';

  TextColumn get orderId => text()();
  TextColumn get orderMergedId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
