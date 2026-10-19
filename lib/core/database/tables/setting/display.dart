import 'package:drift/drift.dart';

@DataClassName('Displays')
class TableDisplay extends Table {
  @override
  String? get tableName => 'displays';

  IntColumn get tenantId => integer()();
  IntColumn get outletId => integer()();
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get url => text()();
  IntColumn get type => integer()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
