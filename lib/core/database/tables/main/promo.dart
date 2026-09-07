import 'package:drift/drift.dart';

@DataClassName('promos')
class TablePromo extends Table {
  @override
  String get tableName => 'promos';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  IntColumn get type => integer().nullable()();
  BoolColumn get appliesMultiple => boolean().nullable()();
  BoolColumn get canBeCombined => boolean().nullable()();
  DateTimeColumn get startDateTime => dateTime().nullable()();
  DateTimeColumn get endDateTime => dateTime().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  BoolColumn get useTimespan => boolean().nullable()();
  TextColumn get startTime => text().nullable()();
  TextColumn get endTime => text().nullable()();
  BoolColumn get monday => boolean().nullable()();
  BoolColumn get tuesday => boolean().nullable()();
  BoolColumn get wednesday => boolean().nullable()();
  BoolColumn get thursday => boolean().nullable()();
  BoolColumn get friday => boolean().nullable()();
  BoolColumn get saturday => boolean().nullable()();
  BoolColumn get sunday => boolean().nullable()();
  BoolColumn get allSalesType => boolean().nullable()();
  BoolColumn get allPaymentMethod => boolean().nullable()();
  BoolColumn get inactive => boolean().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
