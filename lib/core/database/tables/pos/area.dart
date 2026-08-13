import 'package:drift/drift.dart';

@DataClassName('Area')
class TableArea extends Table {
  @override
  String get tableName => 'areas';

  TextColumn get id => text()();
  TextColumn get tables => text()();
  TextColumn get name => text()();
  RealColumn get absisMaximumGrid => real().nullable()();
  RealColumn get ordinatMaximumGrid => real().nullable()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();
  BoolColumn get availableForAllPosUsers => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
