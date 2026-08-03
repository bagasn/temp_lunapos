import 'package:drift/drift.dart';

@DataClassName('Outlet')
class TableOutlet extends Table {
  @override
  String get tableName => 'outlet';

  RealColumn get tenantId => real()();
  RealColumn get outletId => real()();
  TextColumn get companyName => text()();
  TextColumn get outletName => text()();
  TextColumn get posAuthKey => text()();
  TextColumn get outletPictureId => text()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
