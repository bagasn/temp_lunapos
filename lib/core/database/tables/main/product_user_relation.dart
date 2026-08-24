import 'package:drift/drift.dart';

@DataClassName('productToUserRels')
class TableproductToUserRel extends Table {
  TextColumn get productId => text()();
  TextColumn get userId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
