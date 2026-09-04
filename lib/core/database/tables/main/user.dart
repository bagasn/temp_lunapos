import 'package:drift/drift.dart';

@DataClassName('users')
class TableUser extends Table {
  @override
  String get tableName => 'users';

  TextColumn get id => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get fullName => text()();
  TextColumn get pinNumber => text()();
  TextColumn get pictureUrl => text()();
  TextColumn get pictureLocal => text()();
  BoolColumn get deleted => boolean()();
  BoolColumn get permissionPay => boolean()();
  BoolColumn get permissionEdit => boolean()();
  BoolColumn get permissionVoidOrder => boolean()();
  BoolColumn get permissionVoidItem => boolean()();
  BoolColumn get permissionDiscount => boolean()();
  BoolColumn get permissionReport => boolean()();
  BoolColumn get permissionCustomPrice => boolean()();
  BoolColumn get permissionCustomItem => boolean()();
  BoolColumn get permissionAdmin => boolean()();
  BoolColumn get permissionPrintBill => boolean()();
  BoolColumn get permissionSeeAllUserTransactions => boolean()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
