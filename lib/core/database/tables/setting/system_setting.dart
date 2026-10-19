import 'package:drift/drift.dart';

@DataClassName('SystemSettings')
class TableSystemSetting extends Table {
  @override
  String? get tableName => 'systemSettings';

  IntColumn get id => integer()();
  TextColumn get activeAccount => text()();
  TextColumn get activeAccountId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
