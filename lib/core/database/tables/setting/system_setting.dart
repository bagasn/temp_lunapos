import 'package:drift/drift.dart';

@DataClassName('systemSettings')
class TableSystemSetting extends Table {
  @override
  String? get tableName => 'systemSettings';

  RealColumn get id => real()();
  TextColumn get activeAccount => text()();
  TextColumn get activeAccountId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
