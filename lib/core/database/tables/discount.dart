import 'package:drift/drift.dart';

@DataClassName('Discount')
class TableDiscount extends Table {
  @override
  String get tableName => 'discounts';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get discountMode => text()();
  RealColumn get discountValue => real()();
  BoolColumn get deleted => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
