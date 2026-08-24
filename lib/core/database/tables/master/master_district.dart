import 'package:drift/drift.dart';

@DataClassName('districts')
class TableDistrict extends Table {
  RealColumn get id => real()();
  RealColumn get cityId => real()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
