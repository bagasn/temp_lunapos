import 'package:drift/drift.dart';

@DataClassName('employeeToProductCommissionRels')
class TableEmployeeToProductCommissionRelation extends Table {
  @override
  String get tableName => 'employeeToProductCommissionRels';

  TextColumn get id => text()();
  TextColumn get productId => text()();
  TextColumn get employeeId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
