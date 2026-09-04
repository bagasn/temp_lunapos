import 'package:drift/drift.dart';

@DataClassName('outlets')
class TableOutlet extends Table {
  @override
  String? get tableName => 'outlets';

  IntColumn get outletId => integer()();
  IntColumn get tenantId => integer()();
  TextColumn get companyName => text()();
  TextColumn get outletName => text()();
  TextColumn get posAuthKey => text()();
  TextColumn get subscriptionDueDate =>
      text().nullable()(); // 1753-01-01T00:00:00
  TextColumn get outletPictureUrl => text().nullable()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {outletId};
}
