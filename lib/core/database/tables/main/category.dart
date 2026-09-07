import 'package:drift/drift.dart';

@DataClassName('categories')
class TableCategory extends Table {
  @override
  String get tableName => 'categories';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  IntColumn get sortOrder => integer().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  DateTimeColumn get startDate => dateTime().nullable()();
  TextColumn get startTime => text().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get endTime => text().nullable()();
  BoolColumn get monday => boolean().withDefault(const Constant(false))();
  BoolColumn get tuesday => boolean().withDefault(const Constant(false))();
  BoolColumn get wednesday => boolean().withDefault(const Constant(false))();
  BoolColumn get thursday => boolean().withDefault(const Constant(false))();
  BoolColumn get friday => boolean().withDefault(const Constant(false))();
  BoolColumn get saturday => boolean().withDefault(const Constant(false))();
  BoolColumn get sunday => boolean().withDefault(const Constant(false))();
  TextColumn get products => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
