import 'package:drift/drift.dart';

@DataClassName('TableManagement')
class TableTableManagement extends Table {
  @override
  String get tableName => 'tableManagements';

  TextColumn get id => text()();
  TextColumn get tableId => text()();
  TextColumn get orderId => text()();
  RealColumn get capacity => real()();
  TextColumn get sessionDate => text()();
  RealColumn get startedAt => real()();
  RealColumn get endedAt => real()();
  RealColumn get notifAt => real()();
  BoolColumn get notified => boolean()();
  BoolColumn get notifiedScheduled => boolean()();
  RealColumn get warningAt => real()();
  BoolColumn get finalNotified => boolean()();
  BoolColumn get finalNotifiedScheduled => boolean()();
  RealColumn get duration => real()();
  TextColumn get table => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
