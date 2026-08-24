import 'package:drift/drift.dart';

@DataClassName('categories')
class TableCategory extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get sortOrder => real()();
  BoolColumn get deleted => boolean()();
  BoolColumn get isCustom => boolean()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  BoolColumn get monday => boolean()();
  BoolColumn get tuesday => boolean()();
  BoolColumn get wednesday => boolean()();
  BoolColumn get thursday => boolean()();
  BoolColumn get friday => boolean()();
  BoolColumn get saturday => boolean()();
  BoolColumn get sunday => boolean()();
  TextColumn get products => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
