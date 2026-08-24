import 'package:drift/drift.dart';

@DataClassName('promos')
class TablePromo extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get type => real()();
  BoolColumn get appliesMultiple => boolean()();
  BoolColumn get canBeCombined => boolean()();
  DateTimeColumn get startDateTime => dateTime()();
  DateTimeColumn get endDateTime => dateTime()();
  TextColumn get startDate => text()();
  TextColumn get endDate => text()();
  BoolColumn get useTimespan => boolean()();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
  BoolColumn get monday => boolean()();
  BoolColumn get tuesday => boolean()();
  BoolColumn get wednesday => boolean()();
  BoolColumn get thursday => boolean()();
  BoolColumn get friday => boolean()();
  BoolColumn get saturday => boolean()();
  BoolColumn get sunday => boolean()();
  BoolColumn get allSalesType => boolean()();
  BoolColumn get allPaymentMethod => boolean()();
  BoolColumn get inactive => boolean()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
