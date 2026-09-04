import 'package:drift/drift.dart';

@DataClassName('villages')
class TableVillage extends Table {
  @override
  String? get tableName => 'villages';

  RealColumn get id => real()();
  RealColumn get districtId => real()();
  TextColumn get name => text()();
  TextColumn get zipCode => text()();

  @override
  Set<Column> get primaryKey => {id};
}
