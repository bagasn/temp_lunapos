import 'package:drift/drift.dart';

@DataClassName('scanners')
class TableScanner extends Table {
  @override
  String get tableName => 'scanners';

  TextColumn get id => text()();
  TextColumn get deviceId => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get address => text().nullable()();
  RealColumn get classField => real().named('class')();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
