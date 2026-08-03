import 'package:drift/drift.dart';

@DataClassName('Modifier')
class TableModifier extends Table {
  @override
  String get tableName => 'modifiers';

  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get required => boolean()();
  BoolColumn get allowMultiple => boolean()();
  RealColumn get maximumAllowed => real()();
  BoolColumn get haveMaximumItemAllowed => boolean()();
  RealColumn get maximumItemAllowed => real()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();
  TextColumn get items => text()();
  TextColumn get products => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
