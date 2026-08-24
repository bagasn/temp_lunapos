import 'package:drift/drift.dart';

@DataClassName('displays')
class TableDisplay extends Table {
  RealColumn get tenantId => real()();
  RealColumn get outletId => real()();
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get url => text()();
  RealColumn get type => real()();

  // Base fields
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
