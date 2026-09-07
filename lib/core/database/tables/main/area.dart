import 'package:drift/drift.dart';

@DataClassName('areas')
class TableArea extends Table {
  @override
  String get tableName => 'areas';

  TextColumn get id => text()();
  TextColumn get tables => text()();
  TextColumn get name => text().nullable()();
  IntColumn get absisMaximumGrid => integer().nullable()();
  IntColumn get ordinatMaximumGrid => integer().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get availableForAllPosUsers => boolean().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
