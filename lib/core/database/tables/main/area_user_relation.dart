import 'package:drift/drift.dart';

@DataClassName('areaToUserRels')
class TableAreaToUserRel extends Table {
  TextColumn get posAreaId => text()();
  TextColumn get userId => text()();
  RealColumn get sortOrder => real()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
