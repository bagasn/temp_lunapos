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
  BoolColumn get permissionPay =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionEdit =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionVoidOrder =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionVoidItem =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionDiscount =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionReport =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionCustomPrice =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionCustomItem =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get permissionAdmin =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionPrintBill =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get permissionSeeAllUserTransactions =>
      boolean().withDefault(const Constant(false))();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
