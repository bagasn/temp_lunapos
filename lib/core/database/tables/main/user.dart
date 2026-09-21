import 'package:drift/drift.dart';

@DataClassName('Users')
class TableUser extends Table {
  @override
  String get tableName => 'users';

  TextColumn get id => text()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get fullName => text().nullable()();
  TextColumn get pinNumber => text().nullable()();
  TextColumn get pictureUrl => text().nullable()();
  TextColumn get pictureLocal => text().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get permissionPay => boolean().nullable()();
  BoolColumn get permissionEdit => boolean().nullable()();
  BoolColumn get permissionVoidOrder => boolean().nullable()();
  BoolColumn get permissionVoidItem => boolean().nullable()();
  BoolColumn get permissionDiscount => boolean().nullable()();
  BoolColumn get permissionReport => boolean().nullable()();
  BoolColumn get permissionCustomPrice => boolean().nullable()();
  BoolColumn get permissionCustomItem => boolean().withDefault(const Constant(true))();
  BoolColumn get permissionAdmin => boolean().nullable()();
  BoolColumn get permissionPrintBill => boolean().nullable()();
  BoolColumn get permissionSeeAllUserTransactions => boolean().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
