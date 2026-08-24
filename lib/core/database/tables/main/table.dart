import 'package:drift/drift.dart';

@DataClassName('tables')
class TableTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get absisStartingGrid => real()();
  RealColumn get ordinatStartingGrid => real()();
  RealColumn get absisAmountOfGrid => real()();
  RealColumn get ordinatAmountOfGrid => real()();
  TextColumn get area => text()();
  TextColumn get areaId => text()();
  TextColumn get tableType => text()();
  BoolColumn get hasMaxOrderDuration => boolean()();
  RealColumn get maxOrderDurationMinutes => real()();
  BoolColumn get hasMinOrderAmount => boolean()();
  RealColumn get minOrderAmount => real()();
  RealColumn get minOrderAmountType => real()();
  BoolColumn get inUsed => boolean()();
  BoolColumn get deleted => boolean()();
  TextColumn get order => text()();
  TextColumn get session => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
