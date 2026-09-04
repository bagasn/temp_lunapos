import 'package:drift/drift.dart';

@DataClassName('cities')
class TableCity extends Table {
  @override
  String? get tableName => 'cities';

  RealColumn get id => real()();
  RealColumn get provinceId => real()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
