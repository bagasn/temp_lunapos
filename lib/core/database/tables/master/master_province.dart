import 'package:drift/drift.dart';

@DataClassName('provinces')
class TableProvince extends Table {
  RealColumn get id => real()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
