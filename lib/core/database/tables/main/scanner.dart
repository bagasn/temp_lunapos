import 'package:drift/drift.dart';

@DataClassName('scanners')
class TableScanner extends Table {
  TextColumn get id => text()();
  TextColumn get deviceId => text()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  RealColumn get classField => real().named('class')();
  BoolColumn get isEnabled => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
