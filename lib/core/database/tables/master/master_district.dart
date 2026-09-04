import 'package:drift/drift.dart';

@DataClassName('districts')
class TableDistrict extends Table {
  @override
  String? get tableName => 'districts';

  RealColumn get id => real()();
  RealColumn get cityId => real()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
