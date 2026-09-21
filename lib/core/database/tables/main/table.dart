import 'package:drift/drift.dart';

@DataClassName('PosTables')
class TableTable extends Table {
  @override
  String get tableName => 'tables';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  IntColumn get absisStartingGrid => integer().nullable()();
  IntColumn get ordinatStartingGrid => integer().nullable()();
  IntColumn get absisAmountOfGrid => integer().nullable()();
  IntColumn get ordinatAmountOfGrid => integer().nullable()();
  TextColumn get area => text()();
  TextColumn get areaId => text().nullable()();
  TextColumn get tableType => text().withDefault(const Constant('square'))();
  BoolColumn get hasMaxOrderDuration => boolean().nullable()();
  IntColumn get maxOrderDurationMinutes => integer().nullable()();
  BoolColumn get hasMinOrderAmount => boolean().nullable()();
  RealColumn get minOrderAmount => real().nullable()();
  IntColumn get minOrderAmountType => integer().nullable()();
  BoolColumn get inUsed => boolean().withDefault(const Constant(false))();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  TextColumn get order => text()();
  TextColumn get session => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
