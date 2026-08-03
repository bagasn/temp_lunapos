import 'package:drift/drift.dart';

@DataClassName('City')
class TableCity extends Table {
  RealColumn get id => real()();
  RealColumn get provinceId => real()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
