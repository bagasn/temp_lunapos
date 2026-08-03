import 'package:drift/drift.dart';

@DataClassName('productToUserRel')
class TableproductToUserRel extends Table {
  @override
  String get tableName => 'productToUserRels';

  TextColumn get productId => text()();
  TextColumn get userId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
