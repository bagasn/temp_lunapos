import 'package:drift/drift.dart';

@DataClassName('Village')
class TableVillage extends Table {
  RealColumn get id => real()();
  RealColumn get districtId => real()();
  TextColumn get name => text()();
  TextColumn get zipCode => text()();

  @override
  Set<Column> get primaryKey => {id};
}
