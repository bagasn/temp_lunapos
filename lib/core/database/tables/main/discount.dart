import 'package:drift/drift.dart';

@DataClassName('Discounts')
class TableDiscount extends Table {
  @override
  String get tableName => 'discounts';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get discountMode => text().nullable()();
  RealColumn get discountValue => real().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
