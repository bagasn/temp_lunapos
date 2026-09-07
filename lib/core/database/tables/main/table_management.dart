import 'package:drift/drift.dart';

@DataClassName('TableManagement')
class TableTableManagement extends Table {
  @override
  String get tableName => 'TableManagement';

  TextColumn get id => text()();
  TextColumn get tableId => text().nullable()();
  TextColumn get orderId => text().nullable()();
  IntColumn get capacity => integer().nullable()();
  DateTimeColumn get sessionDate => dateTime().nullable()();
  IntColumn get startedAt => integer().nullable()();
  IntColumn get endedAt => integer().nullable()();
  IntColumn get notifAt => integer().nullable()();
  BoolColumn get notified => boolean().withDefault(const Constant(false))();
  BoolColumn get notifiedScheduled => boolean().withDefault(const Constant(false))();
  IntColumn get warningAt => integer().nullable()();
  BoolColumn get finalNotified => boolean().withDefault(const Constant(false))();
  BoolColumn get finalNotifiedScheduled => boolean().withDefault(const Constant(false))();
  IntColumn get duration => integer().nullable()();
  TextColumn get table => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
