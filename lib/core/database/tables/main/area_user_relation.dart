import 'package:drift/drift.dart';

@DataClassName('AreaToUserRels')
class TableAreaToUserRel extends Table {
  @override
  String get tableName => 'areaToUserRels';

  TextColumn get posAreaId => text()();
  TextColumn get userId => text()();
  IntColumn get sortOrder => integer().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
