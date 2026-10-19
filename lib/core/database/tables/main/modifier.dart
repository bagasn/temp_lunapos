import 'package:drift/drift.dart';

@DataClassName('Modifiers')
class TableModifier extends Table {
  @override
  String get tableName => 'modifiers';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  BoolColumn get required => boolean().nullable()();
  BoolColumn get allowMultiple => boolean().nullable()();
  IntColumn get maximumAllowed => integer().nullable()();
  BoolColumn get haveMaximumItemAllowed => boolean().nullable()();
  IntColumn get maximumItemAllowed => integer().nullable()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  TextColumn get items => text()();
  TextColumn get products => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
